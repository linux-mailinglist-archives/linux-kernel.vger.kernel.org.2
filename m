Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0C399395
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFBTgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:36:39 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:38847 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFBTgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:36:38 -0400
Received: by mail-pg1-f169.google.com with SMTP id 6so3113380pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58f97IzlT9KPrXUOhgASh31TIzZpCag1XB0Qb81nEUI=;
        b=EHgAMA+ZqisG673kTLjz3bdglth4r0jB2cYYL8ht+bFLK/bMhSNaGxD7dW+0YldBl7
         4rCcjGdJiruQ5PmWrvXvHkWcqHBAm/sQL53m+Mrl8FHgTR/9HtxDf/LFfkUEMxI8SVJo
         Mu6RcnCpuvTaxmF08HqfiGFJ9H3FB7IVSblXYaLaFz4CSPNwqrkJq+Fwq94sSGsKPN/E
         c+dAodeDfVX9CgHmVGiGqB1C0dSscqE86nAm0yphmtmsG9aFPU3ftvDctfI8tPaz41nW
         CS6nfpdWU2VEIr5UsCR6lvLVsOLeAUoafyOIxa4A4qVT12L41V326PMzIO+MeojisEFt
         /7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58f97IzlT9KPrXUOhgASh31TIzZpCag1XB0Qb81nEUI=;
        b=Z/snh1KYj28EJgwoGje5da4bJZCVdc+8iS2SqKIqqW12CUgQGzX/PmtlZelzddzO86
         jJXkFNUWzCHcIt2LJRKjNClI08QfGpOHUqezAVQhknAz1mEd2P6CC3zunZO9VxeLVxlY
         afM2W/q9Fe3hHrpyHsaoPtUnGqVDa2hy/Ym28qO/MQYEfSRBEhWnUbloeEcappwu+5c+
         g9s076rKbUYz4Poy7/nWDzvE0Fc7WZezbngkGQ5ThD0I5V6K3tqtdphnyvbDS6g+lxkf
         0AYnx3TAFLUP4xz6ah/nwaHtK6L6ISRdWfgTY9aSgTsQKlg3Pr6psoi6D+KexBtvr4O4
         QanQ==
X-Gm-Message-State: AOAM533Y5kf/50bAffvNOoR+qFrZ/PAUqfKxbb1Tn1Cx0FAjn21lvfXX
        xrGUP9onzJTrkyHjuPZeD8X0FLIS+zSHDDY+
X-Google-Smtp-Source: ABdhPJxnWPveGj69ZI0U8HS0L+h5jYErr7asmg1l4w8N7fHlfM/zZHKVHaNpSEdK0KGCoKC/JyK3Qg==
X-Received: by 2002:a62:a50d:0:b029:2e9:c657:feb1 with SMTP id v13-20020a62a50d0000b02902e9c657feb1mr18667872pfm.55.1622662422438;
        Wed, 02 Jun 2021 12:33:42 -0700 (PDT)
Received: from localhost.localdomain ([183.82.156.141])
        by smtp.googlemail.com with ESMTPSA id 30sm520570pgo.7.2021.06.02.12.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:33:42 -0700 (PDT)
From:   Manikishan Ghantasala <manikishanghantasala@gmail.com>
Cc:     manikishanghantasala@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: rtl8192u: r8192U_hw.h: fix checkpatch.pl reports
Date:   Thu,  3 Jun 2021 01:03:29 +0530
Message-Id: <20210602193334.11687-1-manikishanghantasala@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes all checkpatch.pl errors, warnings an some checks
on the file drivers/staging/rtl8192u/r8192U_hw.h

checkpatch.pl tail output before patches:
total: 4 errors, 1 warnings, 32 checks, 247 lines checked
checkpatch.pl tail outputt after patches:
total: 0 errors, 0 warnings, 8 checks, 246 lines checked


Manikishan Ghantasala (3):
  staging: rtl8192u: r8192U_hw.h: fix spaces preferred around that '|'
    code style error
  staging: rtl8192u: put parentheses on macros with complex values in
    r8192U_hw.h
  staging: rtl8192u: fix spaces in r8192U_hw.h

 drivers/staging/rtl8192u/r8192U_hw.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

-- 
2.25.1

