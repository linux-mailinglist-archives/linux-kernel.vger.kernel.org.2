Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751A83A458F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhFKPih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 11:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhFKPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 11:38:35 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5376CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 08:36:37 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1lrjCI-0004Tj-9y; Fri, 11 Jun 2021 17:35:50 +0200
Date:   Fri, 11 Jun 2021 17:35:50 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        kaixuxia@tencent.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, liushixin2@huawei.com,
        unixbhaskar@gmail.com, gustavoars@kernel.org,
        bkkarthik@pesu.pes.edu
Subject: Re: [PATCH 0/6] staging: rtl8188eu: remove hal/odm_debug.h
Message-ID: <20210611153550.7p2deovau37rlpju@viti.kaiser.cx>
References: <20210611002504.166405-1-phil@philpotter.co.uk>
 <20210611091010.GE10983@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611091010.GE10983@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dan Carpenter (dan.carpenter@oracle.com):

> On Fri, Jun 11, 2021 at 01:24:58AM +0100, Phillip Potter wrote:
> > This series removes hal/odm_debug.h, which contains various preprocessor
> > definitions, as well as an unwieldy ODM_RT_TRACE macro which is not best
> > practice. It also removes all uses of this macro, and the associated
> > fields in struct odm_dm_struct which are only used by this macro.

> > This makes the code cleaner, thus moving it closer to getting out of
> > staging.

> Looks good.

> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

same here: looks ok and doesn't break anything

Reviewed-by: Martin Kaiser <martin@kaiser.cx>
Tested-by: Martin Kaiser <martin@kaiser.cx>

Best regards,

   Martin
