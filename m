Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1355F35E743
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346153AbhDMTtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhDMTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:49:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75A2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 12:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nbcw4udwhbGZK1KxJG3rMK3oFZk6fMlWAAr8sT0AiFg=; b=qdyXvIjyqBvlpBNt/ry9bySb5R
        SPRLhCOYGcLYrkePQ0JVs+3n80ANCv9IkeaLafifcOjUkmLdvN3+8mqbOGCo/X28I5H/Zk8liKa18
        jAraWVwhpjf/I42ZViXzJ/GvacHje0ei9bpch4pUKOBNnZ++qGmZxtIwjeNuB6dHdH+ka+7QuEhNd
        RhyCVLBfCdX4H6VE9vrnuM+CKHPdBGUQzCnnbods8UIrTPRIWr4fTCBOtGYCdbfy+f3JBYlXicrVZ
        Pba4ujJv8XNbIreHWgpQVNppvIfdSRMi3m+efGSqW0SbGhY5nMKT23qHpNswMv0ERnEJmQ7rztHH4
        AG0IgAZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWP1g-006BMB-RN; Tue, 13 Apr 2021 19:48:48 +0000
Date:   Tue, 13 Apr 2021 20:48:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <20210413194844.GR2531743@casper.infradead.org>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com>
 <2400087.QbMOWSuNhY@linux.local>
 <alpine.DEB.2.22.394.2104132123180.14108@hadrien>
 <7008359.Jy8utYDuns@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7008359.Jy8utYDuns@linux.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 09:45:03PM +0200, Fabio M. De Francesco wrote:
> 1) The driver doesn't call that function from anywhere else than the macro.
> 2) You have explained that the macro add its symbol to a slot in an array 
> that would shift all the subsequent elements down if that macro is not used 
> exactly in the line where it is.
> 3) Dan Carpenter said that that array is full of null functions (or empty 
> slots?).
> 
> Unless that function is called anonymously dereferencing its address from 
> the position it occupies in the array, I'm not able to see what else means 
> can any caller use.
> 
> I know I have much less experience than you with C: what can go wrong?

Here's where the driver calls that function:

$ git grep wlancmds drivers/staging/rtl8723bs/
drivers/staging/rtl8723bs/core/rtw_cmd.c:static struct cmd_hdl wlancmds[] = {
drivers/staging/rtl8723bs/core/rtw_cmd.c:               if (pcmd->cmdcode < ARRAY_SIZE(wlancmds)) {
drivers/staging/rtl8723bs/core/rtw_cmd.c:                       cmd_hdl = wlancmds[pcmd->cmdcode].h2cfuns;

