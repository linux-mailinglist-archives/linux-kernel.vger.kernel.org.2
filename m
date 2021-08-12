Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1811F3EA1EA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhHLJWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbhHLJWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:22:25 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C42DC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:22:00 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l3so4563444qtk.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:content-transfer-encoding
         :date:message-id;
        bh=k8Za7y9BNnNdxPxBwhOIhVEAkJxwSuy59zGXp6Xfjsg=;
        b=Um0HNbzqlIGBGnTbipSyONivyE0LRgoWchQzm4sCb1Yl7N17VY0wexHzwr/0DI/QcQ
         Y5DfKDFYjaA0jmjLP6oSJgKFy+CgwayZEWhE0vuPQpQ6L0lrOphGOF7NmSw5pZldB0id
         PJtprOg+a9H7P56i7ttku1XToiK95oPtBnT14KFGZ0t8sVE0a0HwqR1mclwkJXb3fVPi
         9of9NKc8RS0mrTaHK4ufXo8uhSK2OYzTT7y4FNRg0iJp3VpJCVPfy1lMknpDvB92uwag
         tI/Nb+9G0K6sXidToCiaOcO/Vem2dseagDhBSbvXyTBJnoMk0Pgj3zToSCCheH5oCZnz
         pUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=k8Za7y9BNnNdxPxBwhOIhVEAkJxwSuy59zGXp6Xfjsg=;
        b=nT8r7HlPzmEI89ABB1Q6nPLZwwgf7gI68ag1mwznW38d3DhopV+8uf2y9gzdKEOoLW
         ARddDm0heuk/e4RWL+Owzq8UiFewvKY74kt7rmZFXs2DXV+2jox/hhBIGAZ+ezgEhnkj
         Qr/SNkciTj7ZIEIfklKw5EKmN80/mEBZ4NxRnkeuasfioL4iTHQuuf3i6qeD96TsJJ6c
         +vIqzTLs4d8GUO2IEJlgL1LKCkSRgv82Q5w3GNSpYG8d6dKngvYCKsVIaeheIep2RyYx
         rGrUqyVbrOAjIQLyGD1t0tIpEMEUBThAJYF18BBDdbp1zSkQbRfcPF1G+EMvE+OA8wur
         SQrw==
X-Gm-Message-State: AOAM5317hzRvlD0HLrfcXPyVA5/sOAJTdWL4XV32OR+Awk2jMG+M1Mlp
        0buKKPn8F3zkyZ/FEr0KfV0JDhjuv/d5jA==
X-Google-Smtp-Source: ABdhPJy0duvwF6KkErETxIiDAT15d9gpPJZ3sEVW0u6uE30W2XfrMutKpaGDS8XpAiEVBuwbM6gMmw==
X-Received: by 2002:ac8:4986:: with SMTP id f6mr2896683qtq.125.1628760119637;
        Thu, 12 Aug 2021 02:21:59 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id z82sm235580qkb.95.2021.08.12.02.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:21:58 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     SeongJae Park <sjpark@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1628760117_131750P";
         micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Aug 2021 05:21:57 -0400
Message-ID: <144813.1628760117@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1628760117_131750P
Content-Type: text/plain; charset=us-ascii

In this commit:

commit fedc37448fb1be5d03e420ca7791d4286893d5ec
Author: SeongJae Park <sjpark@amazon.de>
Date:   Tue Aug 10 16:55:51 2021 +1000

    mm/idle_page_tracking: make PG_idle reusable

diff --git a/mm/Kconfig b/mm/Kconfig
index 504336de9a1e..d0b85dc12429 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -739,10 +739,18 @@ config DEFERRED_STRUCT_PAGE_INIT
          lifetime of the system until these kthreads finish the
          initialisation.

+config PAGE_IDLE_FLAG
+       bool "Add PG_idle and PG_young flags"
+       help
+         This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
+         Accessed bit writers can set the state of the bit in the flags to let
+         other PTE Accessed bit readers don't disturbed.

This needs to be converted to proper, or at least comprehensible, English....


--==_Exmh_1628760117_131750P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJhFOg1AAoJEI0DS38y7CIcBLEIAK+L0bWo/4hHTrV7BpfRC64Y
8EYl2LHlAKzSfjoKkGWm9KuLTXMApo48HCBbXITrG5xExJXLA8YjhmuGJZptHXxD
97ZAJXuqcqZRHs7zbeJuxWlrXZ9fwK9RDHhUWVGqmoihLCsNig4lrqSYQuDz4wb6
FNftPz4IWXtulrWYLheBzfIbZeGAFFUvL5hcNoqA6E0/IW0dexHcmfVnp4SKnZ71
1j53PxPZy/2EZ45cmHlhzjwc356QnZCjFkxzptX1vRA3BR+exarhSBeNT2kpwq2F
Ma3pL2UpeiSQG0LjQPOdLLaSIGxEulCVvtE3XmPe8SrYF272wHf+tgqJzioniFg=
=vB1r
-----END PGP SIGNATURE-----

--==_Exmh_1628760117_131750P--
