Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3A239D945
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhFGKHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhFGKHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:07:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B9C061766;
        Mon,  7 Jun 2021 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=cmSrIn2bRsXxxMIObpSonrRHL+
        W3L+L+q04e7hXJguzw7tPCU8OtmGlTeuPh9zxf85xv+BtaCsir07vIUw5fRw35lpnKVTYDvVU8P7/
        5o3xZuVN1a9BNppBYiuAarPYvHrXXIG333AlQwYtfl9RFY40Z9tU1490NYPAKC/pov3LjHD3jsDzm
        kMam0K7U2KS1kaJL1aKR4gf6M2XOuvs9WTdYQ3KnUE6TU1qOyuiM2+nk+Mp6uvE3LG+sGeRmaukVW
        eiMGMAb/LKo/w1jriFQ2sg05HObI8iByL/gQCRsSa7WqnAsccqZ0RXI2TpZWLdugBvEBKUiYJSu4p
        zNAFaxoQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqC8h-00FbtW-6n; Mon, 07 Jun 2021 10:05:53 +0000
Date:   Mon, 7 Jun 2021 11:05:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] usb: dwc3: support 64 bit DMA in platform driver
Message-ID: <YL3ve/rxTlIzErlX@infradead.org>
References: <20210607061751.89752-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607061751.89752-1-sven@svenpeter.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
