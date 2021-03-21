Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E229343435
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhCUSzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:55:23 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:17236 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhCUSzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:55:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id AA3483F63C;
        Sun, 21 Mar 2021 19:46:10 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=RmWTAfau;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iRxq6b07VQNg; Sun, 21 Mar 2021 19:46:09 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 535103FEC9;
        Sun, 21 Mar 2021 19:46:08 +0100 (CET)
Received: from localhost.localdomain (2.70.38.73.mobile.tre.se [2.70.38.73])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 60178361E58;
        Sun, 21 Mar 2021 19:46:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616352368; bh=tpeEGuLEfQbIt3oYJJ199Odz5KIao0YiVWQXjQK8Lz8=;
        h=From:To:Cc:Subject:Date:From;
        b=RmWTAfauY4F3Mp79+y8c8xmdXcwmIyMEawbzs1nWiS50q/d34+9fMyikQDrWwmL7r
         JQewrmix+tKc9qc01LwSAIazwqYJGlwnJ4hOQ5q5C7AkB9dAJN3Tm4HQ9qyX1TQ6rI
         +SrDCDkneIo5NT8q+PUBouUIxexKDxTFW7yihLuE=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28Intel=29?= 
        <thomas_os@shipmail.org>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28Intel=29?= 
        <thomas_os@shipmail.org>,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] mm,drm/ttm: Always block GUP to TTM pages
Date:   Sun, 21 Mar 2021 19:45:27 +0100
Message-Id: <20210321184529.59006-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_user_pages() to TTM pages is uwanted since TTM assumes it owns
the pages exclusively and / or sets up page-table mappings to io memory.

The first patch make sures we stop fast gup to huge TTM pages using
a trick with pmd_devmap() and pud_devmap() without a backing
dev_pagemap.

The second patch makes sure we block normal gup by setting VM_PFNMAP

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Thomas Hellström (Intel) <thomas_os@shipmail.org>
