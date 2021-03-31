Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A93507C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhCaUGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbhCaUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:06:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5714C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:06:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so1796572pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BRuM09+J2aRYPZ9OUTp8R2fLyI9MYToqI7peFMSk8bU=;
        b=lAAjckvzUujgug8k3+FTIryj68kvDL02K8IHYw3YEo7xayLfRq29/56j0AleZqRWmO
         MDKvhVMKrTw8/hC2PD8PmBjm6C/hT60ToS4UQQuL+VzFptkWlcTn296vC08QtiRjBzIU
         qTbtF56f0pARvIlV498lLIHWT7wzZk6Xe2Q3xjqKKyGk7ZIWYydCcHsiiJwZxPXu2+3S
         HdagR7njK7ErZ7/pAx7LyjpxBWEu5Sc8KgF5rpqHa3fNdYrHeodE8FEYEa+czQNMgmiW
         kBURRanz0kXdXPa/BOo6lik3yXnAu31YJk7tXGE5xzosh4Sy7JYNFTsatXMMy3SJ+ef/
         JZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BRuM09+J2aRYPZ9OUTp8R2fLyI9MYToqI7peFMSk8bU=;
        b=GdJjQUa9gaxWdf+7+EjFHcmCAjE81SdsfZ8k3bwWLdTzNwiClrt5aIVxMIrnRuttsi
         tNJTMPz8m/+6uIjqtkCdItcbyF9iIZJ6oOfVpJs42PGrridTK5Ue19O4HsSKKecg9U3a
         T3uNjf+D2/Qs60VlJHKqb6lXktECo3+QdU3yETGlB+bhmLYdFPltzLG4MDf24d3Anxb8
         cpEbABGnV7UXFF2vJEsjJVSFvx+TbVsSd7VHRX/kVocmnV15s2F1sTrOUoICjg9Dznv3
         htv6ZrMZiIGXdVqHIU8tNb7nvwiNrWge0aboyWbqp+PlC9K7yKwqVKYRrKjgtJUksFX2
         p9aQ==
X-Gm-Message-State: AOAM531ksKRI4XYyY2TSSd1pTgorpf+0wTek9WjRckjsutoXvH589c4B
        /Q9ss0fuOXHgKYTHlSyFf08=
X-Google-Smtp-Source: ABdhPJwWCA498WxMX0SwPucZ1+YRNBumZ/NsIqqI8w29sQPpE8+Kt23WJFbltg5pKSkZiVBRQ+CRRA==
X-Received: by 2002:a17:90b:2284:: with SMTP id kx4mr4958415pjb.96.1617221185463;
        Wed, 31 Mar 2021 13:06:25 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id d22sm2985668pjx.24.2021.03.31.13.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:06:25 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH 0/3] Fix block comment warnings
Date:   Wed, 31 Mar 2021 13:05:34 -0700
Message-Id: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes checkpatch warnings arising
from the block comments

Deborah Brouwer (3):
  staging: rtl8723bs: core: fix repeated word warning
  staging: rtl8723bs: core: fix block comment warning
  staging: rtl8723bs: core: remove empty comment

 drivers/staging/rtl8723bs/core/rtw_xmit.c | 61 +++++++++++------------
 1 file changed, 28 insertions(+), 33 deletions(-)

--
2.17.1

