Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9B9349A22
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCYTYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCYTYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:24:21 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90792C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:24:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v15so4171952lfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=L8T2Txzb0BtewZ5F66NCn7EN1kBqfXmON7PRQ3Cxnj0=;
        b=uz61an9M1dHhsmDDzYlBWKFkQ0xFbDqOq4tzPA/WEzSnTTQCl2j5f8LgyUWMqy2g09
         rdNbc0rSfLnOZbF0YVzDhVv9e89BB5Og4wIpAp2lAyNINw48Noa07QzbgcsxalTXL4te
         D9TmW4W0KtLb8SQ03Bb0h49PnnjNgh67Wbf+64r0HmxesLknzb/SBwbmT1MWQwu/Dwwb
         UxwEmRS/qlYXp7WfviJPQzKD6EuRRh3cBE6TsOCveAzkZkR+ova0kT9Rv2sGUpN9hBNJ
         xI5O2RvX7yTKVqc3T/l+xd0VUH+Z/ZT9EB//l7xYB73ukuS3iI1mdqcRLXdP03/MJvKB
         eHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=L8T2Txzb0BtewZ5F66NCn7EN1kBqfXmON7PRQ3Cxnj0=;
        b=o9BCv8T26gD/QF6HtfBpA8cVXYSBoZzvZa9eFBItePjIU5Kjx8Qp4FgZ7aJnOweLNp
         vbPUfanBNm6SYk1hoh0O4HjUbqye9vmuOV/H975+7/9bccVUt79Yk3776EReTBSJe178
         OuND+VbiPFnDFifdmX3IdW0hUmC2AKgHPlnSE6sOHzUEwh+PFmcDX1eBz3s5SKd03Oad
         Ddyy4WQfHy6uIjmi1Ax/ndjLCUfhJx26BUxz/nmaWWYGl8Ms62Wk1Z/dHolgrGk8MSOp
         vfl/kj7nE2AzJOBAsiTDIe4vHj9rf7bWrmzGpoZ2+Dq7FH2ReG5WzFQsMc3daxBLoghP
         r5Dw==
X-Gm-Message-State: AOAM533wnQIwHN+UaCzDXe/Rm3/JG4o9yTEBS8FcRUu3/RWepPzu4lt3
        Tj9/uzpJHZfpQT9eGXFr/XJaWmBYHCbtJNtXaTU8nw==
X-Google-Smtp-Source: ABdhPJxEDGp3bUqaucqZOvhWWJyy62pP51Q7wESmTwcPqVi6x5pXOBqg5AJ+vA5ZqsgTOVe3+NhxCi9R/Xf9egb2B1o=
X-Received: by 2002:a19:6a16:: with SMTP id u22mr5622616lfu.356.1616700258737;
 Thu, 25 Mar 2021 12:24:18 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Thu, 25 Mar 2021 20:23:52 +0100
Message-ID: <CAG48ez1wLkMCiyY+bWVonXZr2TjzhwKZjNZLD3Ads=Rds8YJSw@mail.gmail.com>
Subject: ARM FDPIC_FUNCPTRS personality flag handling looks broken
To:     Nicolas Pitre <nico@fluxnic.net>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>
Cc:     Tavis Ormandy <taviso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Tavis noticed that on ARM kernels with CONFIG_BINFMT_ELF_FDPIC, it
looks like the FDPIC_FUNCPTRS personality flag is not reset on
execve(). This would mean that if a process first executes an ELF
FDPIC binary (which forces the personality to PER_LINUX_FDPIC), and
then executes a non-FDPIC binary, the signal handling code
(setup_return()) will have bogus behavior (interpreting a normal
function pointer as an FDPIC function handle).

I think FDPIC_FUNCPTRS should probably either be reset on every
execve() or not be a personality flag at all (since AFAIU pretty much
the whole point of personality flags is that they control behavior
even across execve()).

(I don't have an FDPIC toolchain, so I'm writing this solely based on
having read the code, without having actually tested it.)
