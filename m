Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAC634BA3F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 01:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhC1AH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 20:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhC1AHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 20:07:23 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C7CC0613B1;
        Sat, 27 Mar 2021 17:07:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s17so11706580ljc.5;
        Sat, 27 Mar 2021 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=R4sPls4WqyaT0nGux32T28YvbCaupL+g+Q7P0/FqKzs=;
        b=oGkHyRoXWUxLpCWJ60KEpmucPGlKS4Mxn7BznMDhHGlTuGnoytw/er4fa7JMe9YsOX
         /OpKCesGAnwweCVO+LI8TVMbmNPZGyMm6dtXjXPwuV00ISrhVrQbtKjCROoFLfphBVMA
         Ph9keiahCOWgjoX0F7V/1ohoWrkifPitVIzKwXqUPL9VKlYZOSLsMee+eS6WmGEB/iEW
         MkZ+NaMqBPNAjwsZtwWDj9iRZbVg2boOsZhT6Ue7PZZGjoYk1LgSqOwAl4IxfUNIGsSx
         XhCI6mrCTpmU6rXSn+OHjUyftbOp/fi2oj87+T5worsGcfei7lNxHIDiNjnSa2i6z9pp
         UO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=R4sPls4WqyaT0nGux32T28YvbCaupL+g+Q7P0/FqKzs=;
        b=n/KcGdk1ieeqRdtazPMC5dcKFVtomnIEZaKRMHnd4NC8HqfoMBUBSfLnYpzeSiCKut
         m151aidwkY9TPPcCPCB1JZcMHM85VMFiQPWpa6fNWr33Li1cIJtUAv74PUY2AG57/s7l
         e3zmICoqjsNCMNYsOH12Iqu/mTb2tVObuXe/mSkqYi0JnjhpheJCQRgOEhSnMn8kZpUs
         Lm6L9m6p6D5ZV/vFNCVoS5SwFACRurK8oveSor+59YvBNexbLtGcw9Ze+3XbtwA/hpxe
         EObzAtXQBXH32Kc7ZyL4R1cYPDiOcCCHJ6WKAxjVX6meunFKugxJss22MA3rfk/wlHcL
         7SmQ==
X-Gm-Message-State: AOAM531ygcQICvNKA+f2uAA028oBgfEG+FDelfNmiJcEzyJp7kYh6Fx/
        Hp+VYHkcQoB8N8QWciNkpJlix1IdsfJ0GBwexNEBAkavUEvWcg==
X-Google-Smtp-Source: ABdhPJz+Pvqa3gsFbNbJw3Md4SZ71S0AbwQFNlVTm4InIwbGbuovA5ieM2jyDBynst8gzMZ7sfoLdgRfEGXfzvdm+Yo=
X-Received: by 2002:a2e:1612:: with SMTP id w18mr13800401ljd.6.1616890041534;
 Sat, 27 Mar 2021 17:07:21 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 27 Mar 2021 19:07:10 -0500
Message-ID: <CAH2r5muJ0vRicetgiFOaMecoqGYZw7p+LAEYSs5OLADyzewFiw@mail.gmail.com>
Subject: [GIT PULL] CIFS/SMB3 Fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.12-rc4-smb3

for you to fetch changes up to cfc63fc8126a93cbf95379bc4cad79a7b15b6ece:

  smb3: fix cached file size problems in duplicate extents (reflink)
(2021-03-26 18:41:55 -0500)

----------------------------------------------------------------
5 cifs/smb3 fixes, 2 for stable, includes an important fix for
encryption and an ACL fix, as well as two fixes for possible data
corruptions (one for reflink and one for SMB1)

Test results: http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/543
----------------------------------------------------------------
Ronnie Sahlberg (1):
      cifs: revalidate mapping when we open files for SMB1 POSIX

Shyam Prasad N (2):
      cifs: Adjust key sizes and key generation routines for AES256 encryption
      cifs: Fix chmod with modefromsid when an older ACE already exists.

Steve French (1):
      smb3: fix cached file size problems in duplicate extents (reflink)

Vincent Whitchurch (1):
      cifs: Silently ignore unknown oplock break handle

 fs/cifs/cifsacl.c       |  3 +--
 fs/cifs/cifsglob.h      |  4 ++--
 fs/cifs/cifspdu.h       |  5 +++++
 fs/cifs/file.c          |  1 +
 fs/cifs/smb2glob.h      |  1 +
 fs/cifs/smb2misc.c      |  4 ++--
 fs/cifs/smb2ops.c       | 27 ++++++++++++++++++++-------
 fs/cifs/smb2transport.c | 37 ++++++++++++++++++++++++++++---------
 8 files changed, 60 insertions(+), 22 deletions(-)

-- 
Thanks,

Steve
