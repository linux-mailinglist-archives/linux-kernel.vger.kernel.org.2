Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2538D401767
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbhIFIAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 04:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbhIFIAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:00:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2AEC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oOFV3aBUUEEGyqvLAa8hfq+cLKEmGeypv5PDL5XSJEM=; b=by6aIIKk03uvjCAvjPQuiYUlYE
        q8jRCXMRztEBoYU6O426ssAa9KcZpWfL7ER69FBal0pENP/9S9hiDu1+3L/9gxeSdo9RZ3u94P8DZ
        7NUGUe/KKYoWXIosJyAtBybX/FhZrMPjtKeXMVWUHfzIUqN/HGjdu5jv7b7cvb5aSXzkLlQBLPifT
        NkFw9vOu94tiT8ASL57JcFX0gxW3bL6BQtG0+GsbC/qP8ADfRhm9Q8PHxGg+WjML1lYHahFPsAdRu
        BmAxQbpLkqEOS56c5hRngdiN87/7M6je6BTpnu4erJAHpeNJqePeIjCwZAOPyYogPvlvAkQesFON1
        QtAzB9sg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mN9WG-006kn5-7B; Mon, 06 Sep 2021 07:58:29 +0000
Date:   Mon, 6 Sep 2021 08:58:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] nvme-tcp: enable linger socket option on shutdown
Message-ID: <YTXKHOfnuf+urV1D@infradead.org>
References: <20210903121757.140357-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903121757.140357-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 02:17:57PM +0200, Daniel Wagner wrote:
> When the no linger is set, the networking stack sends FIN followed by
> RST immediately when shutting down the socket. By enabling linger when
> shutting down we have a proper shutdown sequence on the wire.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> The current shutdown sequence on the wire is a bit harsh and
> doesn't let the remote host to react. I suppose we should
> introduce a short (how long?) linger pause when shutting down
> the connection. Thoughs?

Why?  I'm not really a TCP expert, but why is this different from
say iSCSI or NBD?
