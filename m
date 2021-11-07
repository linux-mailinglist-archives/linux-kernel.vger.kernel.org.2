Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513C544739C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 17:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhKGQDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 11:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhKGQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 11:03:23 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2924C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 08:00:40 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f3so30450499lfu.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 08:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=kkACn1btCavBEb51T7Ix13waIKrDUw9bUC6GnjGIDt4=;
        b=lv6cSv3D9142llvgNRGCEUYO0GZGHd11lTWsk7KaIVKjeM9mR9X1ZRvyr/qrCnVGr4
         /waFZ6R2pXgMIKQIyO5cO10zW/H1wapE7EaZS+OIizylz4WY//2fohL41XNIgW8Jg2qG
         u8UH7+dDm6Hj2Vd6Pv8pSDzgjVO9ghWwsvjq/dTau6FTCyM2wK82LBe4Z3P8AXjQQBjU
         MKhkhOYyyWelvCd7DGyX5XgFjeoYaja0uLAthv9lHAQzaRlAcl1sRKvAAVyH80j9OFtg
         GhpiRYqH26r1zGrYCC+YpKW+3PUr2LEX3H4zAu+z8fA4DvsgdLbrvg9jCX3eQqaBrdc/
         rgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=kkACn1btCavBEb51T7Ix13waIKrDUw9bUC6GnjGIDt4=;
        b=N+Vk7445ZWAlqL1mEJbfrFl9CG4U6mlHQyOk3kdawadDyc1V9+v3Fvag2nSFtcFc1Y
         9nDQ22jk4Cmatqt3GvX6UmtSpjSiDB7oIbLQgt82T7oLsuto3MiRbF7JNM1kYrk8NKNV
         OL+GXRpHFM3KiBLNq06dEN/3CJqEGf1xXBvWT71SadxwNOyh5ujGRrPD3BCTBx85w3IQ
         F4rOAwFEw+5odBtaOs0wN80VknYNqMxvqVSOqx9QyGN20kF/x2TRTqUSXJ9z+99/oD+c
         iPjQS9chKQASYAyGKDlDqvVXs0RuJE2q3+CWHTLCYCvsZ/96qMcimYxuPU3o7yCBFMeu
         YR2Q==
X-Gm-Message-State: AOAM530mNSwaiNoj2jLF2KxaiE8D1zpz8pEqXmMy5F3l9GcsXWorJqQy
        4WtDiH2VJYJr3kmKIYPX1qQLheyWX8dVpA==
X-Google-Smtp-Source: ABdhPJzL+esdO/lgmo8syzU4hXs5um/cN/2JwTwM4aatfDXCVzJglkNkgOqktQ5NbohNelxIjb6FOw==
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr66023189lfb.71.1636300838605;
        Sun, 07 Nov 2021 08:00:38 -0800 (PST)
Received: from smtpclient.apple ([185.218.110.221])
        by smtp.gmail.com with ESMTPSA id o16sm501669lfk.109.2021.11.07.08.00.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 08:00:38 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Lucius User <lucius.q.user@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Sun, 7 Nov 2021 19:00:36 +0300
Subject: ITLB Multihit mitigation status report is confusing. 
Message-Id: <6D53FB74-4B6C-48A0-97BB-300A9C81B55C@gmail.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (19A348)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.=20

On a cpu that is vulnerable to iTLB multihit, with VMX enabled in bios and n=
o vms running, the kernel reports the mitigation status as "KVM: Mitigation:=
 VMX disabled". Once a vm starts running, the report changes to "KVM: Vulner=
able". Shouldn't the VMX disabled status refer to a situation when VMX is co=
mpletely disabled via bios, not merely not in use right now?

