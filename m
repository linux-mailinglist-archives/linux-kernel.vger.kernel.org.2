Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C16340595C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347520AbhIIOnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347455AbhIIOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:43:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79C4C0775BA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=L3qmcK3XkQzX1OlMFGFtDWNbY0
        qtI15ELaCsKkWGvpAawroOS6JWsTTbdothZBIAW16MUTesRG9wc3t8+CsoJbjj+fv5DTfAURJATGC
        QNFw6OQCyckTlyzl9EAgo3rLY4SsSEkBEQVQQlEisIZxq+szABZGxXFbntoXHkdyAE1pDZT7o15rW
        9+3P5kEHN9Pt8HA9VqlXtxWp09Ts6hinVhGam9dgcOh0yKyQP8lGgFI6tM3ae0OKdGFj3yQxJ8DH/
        HuoQodL2pGqH51vOBL7AuWROIQYrbISCmzLd49a4TLR9YvjAMwoT6yVLhbsB5izvD+nW0Aca/2gKO
        Tkm2/hfw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOKk3-00A2rp-B6; Thu, 09 Sep 2021 14:09:49 +0000
Date:   Thu, 9 Sep 2021 15:09:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme: avoid race in shutdown namespace removal
Message-ID: <YToVl5VTLwPkHkpO@infradead.org>
References: <20210902092002.67614-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902092002.67614-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.15.
