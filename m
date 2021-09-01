Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C993FDD06
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhIANDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347634AbhIANCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:02:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02449C00F760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 05:46:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bt14so6408984ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 05:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=1eYpRrKuq5ZgpaR7KFaa/OqjmqBojbgOC4rUwGRD3Vc=;
        b=Ow4DgO+XUX/KRgaa6j9ptxEycq/MyLM3NIKnlM/8xV2ODdborxsSSthK5im3sSMObU
         fl5QTECdev2+X/XWOi7co1t9DKm3M4VMeZCMkBMs/8QM9bWRMfXLnJ4GAje8JNTX2lxF
         5EAsztLErwhPs58nzn0a4tf0J95x4PWHuiNa1KUoLcvYIR4fwibzswVzU+OXsNwIZ1cf
         k8EpOQm2U1PWipRnciDcNAzcGwu8MJJfibOHo8HQL99/xIZ8x1xl6sykS2GiT0kX6/Zh
         mKYeiH0y++sutzPO/5Jt7K1OoXffcmAGhxPF8LAHOI0VG7Nuf2zfPA2WM8DVM9tFaGo4
         Zc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1eYpRrKuq5ZgpaR7KFaa/OqjmqBojbgOC4rUwGRD3Vc=;
        b=rB06iIxRpCdR85POSpJzihuLPLRo5b+pHSUBMwTOcvs+G/zpg8Ti7C3zHPIOhRI8By
         a5O80rjHOYgIkmn6i31llDKtUpd6Dt/8RekYEMTqENVtpNxOMImytaYe+3pYbKBKHvx1
         ee//XezArteoFd6ZNFFceXem9iAS1+0fPuNobYDdXIjhuCaIG5E30M79ofanDEtzlGcP
         AH2HZxT8Ta1BShCiVoYBN8s5z4jzJYfXQ7Q1hW+jyo3AHnL+UcCSBoZI4XYjrlv29QaC
         qUFGKqPj+uJfpauxGW7Z0ga+ofABPnjC8MemVaOh9oiPCBn+QyUr2M25U1VUsCaQ5m2f
         Umlw==
X-Gm-Message-State: AOAM533/Cl4Z/9ZjVplpNhuNeGWfPBmjmn4L7JcVTHgQfWk9LK+mCzbD
        IxgO712Niy8s9wcZE3xvpUnOA6pkdzzUpcYPtHf59vj61ao=
X-Google-Smtp-Source: ABdhPJzwFCWiMdF2QV3MksklNLypVvXZKi/z/X+1s5JZAMYBu0bTnDOM5u8XDxjDfHicad97eF/0t57Vx5d3k3+uLhE=
X-Received: by 2002:a17:906:f117:: with SMTP id gv23mr35161512ejb.406.1630500389353;
 Wed, 01 Sep 2021 05:46:29 -0700 (PDT)
MIME-Version: 1.0
From:   Zach Hopkins <hopkinsza@gmail.com>
Date:   Wed, 1 Sep 2021 08:46:18 -0400
Message-ID: <CAMUM20j2Z7mL4w1-SkHUd1LN0h9wUs-1+aOTeZExFkRhx4=dKw@mail.gmail.com>
Subject: kill(2) Syscall Behavior with pid=-1
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

I believe I may have found an edge case where kill(2) exhibits
unexpected behavior. The context is with only 2 processes running atop
the kernel -- an init and a compiled C binary. According to the kill(2)
man page, it seems that `kill(-1, SIGTERM)' should return -1 with
errno=ESRCH in this scenario (when run in the C binary), but instead it
returns 0.

Relevant parts of the linux man page are as follows:

1. "If pid equals -1, then sig is sent to every process for which the
calling process has permission to send signals, except for process 1
(init)"

2. "On success (at least one signal was sent), zero is returned"

3. "on Linux the call kill(-1,sig) does not signal the calling process"

In this scenario, the init and the C binary are the only processes
running on the system. With pid=-1, no signal should be sent to init or
itself due to exhibits 1 and 3. There are no other processes which could
possibly be signaled, so therefore the kill() should return -1 with
errno=ESRCH (No such process).

This was found while running Linux 5.13.0 via qemu. Testing the same
situation on NetBSD 9.2 gave the initially expected results.

Thank you for your time, and let me know if there's any more information
or context that would be helpful.
