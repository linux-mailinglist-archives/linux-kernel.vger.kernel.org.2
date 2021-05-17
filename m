Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DDB3828DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhEQJ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhEQJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:56:51 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06965C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:55:35 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 17AE3C022; Mon, 17 May 2021 11:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1621245332; bh=iGA5eSg+mjfIWtklRF7HSD5WpIudKPdX6AmBTYCPB8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGmjDd+6RsTbV4emCbR4gw3SkQDoD+eYX4su0RY20iS3iK2LxXVrZrmtbyes4yOqX
         yC1Q5LaKuXc1NI4KYedS0ZT7230HuqgdCRO4bFLhGiWOTz5iZS5RBCFKHKbsVM3c9S
         93JuKG+csGcOHSQ6N/YwXbeqNApjoMbQudp/IptdZAzPHLRR2cszfD5Rw2/Zs23AHa
         EtFy5OLLnvAAqOh4sXIND7TpoXi5QLx+CjzBL+JFsyDqaBrRENzMCt+io+STPJNXSU
         VcyWyHTlsFmMZ2j6EV9ClLRJR0+X758AYVc9tSuA7otAoGE2DLTXAaAZA7w6Ianhrj
         7ae16Z0tCkC+Q==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 2D8D8C01B;
        Mon, 17 May 2021 11:55:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1621245331; bh=iGA5eSg+mjfIWtklRF7HSD5WpIudKPdX6AmBTYCPB8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeQjdANHXOZW0xK7N2g342pEnK9Wk/zFm2MvsiDnabxxpLnCGFuWUDUS6cEbBr2EO
         MqtxQgmAWH4aeB01H8ufPmZ6JCnub5obWHV8U8XE2S2T3nrc3XuNsG69onrf4Arsm7
         O89cmDHEYTpnnuHipIvLL8NNkDDD+6yKD2S7zoWz0dvOpCjMOKi7F6ekyVWiOHTr/v
         wdPRjLBZ18g9zBDIzgBdZLV78PB7AW8YNnDW+gbEIIm+QK38++hJlcNSRowpYkFsU0
         4t4a9wUzAPCUVBCyalqPqFB5Y6SsoN1oglMlDzxeeJNdbKpJKxmSpgGEENQGyC/cKW
         427wlmgkKsGNg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id e628bed6;
        Mon, 17 May 2021 09:55:27 +0000 (UTC)
Date:   Mon, 17 May 2021 18:55:12 +0900
From:   asmadeus@codewreck.org
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p/trans_virtio: Remove sysfs file on probe failure
Message-ID: <YKI9gHMjbz8nAvYp@codewreck.org>
References: <20210517083557.172-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210517083557.172-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xie Yongji wrote on Mon, May 17, 2021 at 04:35:57PM +0800:
> This ensures we don't leak the sysfs file if we failed to
> allocate chan->vc_wq during probe.

Right.
I'll add a Fixed tag and take to -next shortly

-- 
Dominique
