Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4AB318C09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhBKN2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:28:25 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:44982 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhBKNGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:06:10 -0500
Received: by mail-pg1-f180.google.com with SMTP id j5so3805414pgb.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 05:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8sQZFVyzFUSfXMDM4JSNiF+doI5yrX0baGAIT672MoU=;
        b=ZyazIiv5Z1rzkZRYcF1islO8xDkalIfPYBtMK3QuEPeZmUv3CeaFfd3bDFEMXGO7h6
         cmOPJ5YqVqbVkTkRaoSyVPw0HKBkG4Un6k7cMLrF/A+Hub2txst6GApZl/UwAIXHxSpR
         VbvJkF29rGm1VJUKdmOSSewg7SGPLz1fhUqujspMI6lpLUth08+vdOg2Ab5RClca6Mnt
         Mg/B9bnkxRjlICxamxumZbCF4slrIMEfnIBsEbHfEfxHdlz+/pveL6R46rsZptaNyjRW
         H99keOWvbTgWirWZzMnzZ+/lNLGRhXE45uygtkasexOz4Tiyk8a9S4PeQfyiwbm0FOi2
         N+lQ==
X-Gm-Message-State: AOAM533BGjQps+4NP+mKTUD4qeGI+8NLEqJZiRuKQZqQcv5w0XpoozRH
        6jAiVj/307q94Nd0JSt39M8=
X-Google-Smtp-Source: ABdhPJxPn+gPZnQfttZeQw7M8amvTYPBSRLMPHxpf34tKIeAHp03aB4aF6THjle1iMaQI8HWR8OB+Q==
X-Received: by 2002:a63:c911:: with SMTP id o17mr7932806pgg.102.1613048729367;
        Thu, 11 Feb 2021 05:05:29 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.38])
        by smtp.gmail.com with ESMTPSA id n15sm3705963pfd.143.2021.02.11.05.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 05:05:28 -0800 (PST)
Date:   Thu, 11 Feb 2021 18:35:24 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] staging: rtl8723bs: driver cleanup
Message-ID: <cover.1613048573.git.mail@karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

karthik alapati (2):
  staging: rtl8723bs: fix function comments to follow kernel-doc
  staging: rtl8723bs: remove obsolete commented out code

 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 225 ++++++------------
 1 file changed, 75 insertions(+), 150 deletions(-)

-- 
2.30.0

