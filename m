Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AEF3E9922
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhHKTmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhHKTmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:42:47 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A4C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:42:23 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mDu7C-0004ZB-D5; Wed, 11 Aug 2021 21:42:14 +0200
Date:   Wed, 11 Aug 2021 21:42:14 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH] staging: r8188eu: remove rtw_ioctl function
Message-ID: <20210811194214.35kfmx4u6t7leuyt@viti.kaiser.cx>
References: <20210810074504.957-1-phil@philpotter.co.uk>
 <20210810080640.GV1931@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810080640.GV1931@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan and all,

Thus wrote Dan Carpenter (dan.carpenter@oracle.com):

> Phillip, Michael, and Martin,

> You are all working on this this same driver.  Could you Ack each
> other's patches?

sure, no problem. I'll try to look at r8188 patches from Phil, Michael
and others as time permits.

Best regards,
Martin
