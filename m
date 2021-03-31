Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65851347BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbhCXPOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:14:52 -0400
Received: from mx4.veeam.com ([104.41.138.86]:36620 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236414AbhCXPOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:14:20 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 35A2B114A62;
        Wed, 24 Mar 2021 18:14:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1616598855; bh=ajKj4AgUojDeKoeK4aucvD7WQjAp/h50svuAT5cpfok=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=j8lDhnO8OHkqPTIzkuDcDCCRKU7aDuCUuzBsgZrIOBahIi3qlQTd+46bxoGFyNPda
         yozoYKB1sHH0vrknXoaA1INzZ27DLaSeh/aRldkXuckxNBvOn1zbnX5BmnoNb0hen0
         bBUoXKSN679c5Wpcs0C14FdaMND4jK68n4dtYsBw=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Wed, 24 Mar 2021
 16:14:13 +0100
Date:   Wed, 24 Mar 2021 18:14:05 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pavel.tide@veeam.com>
Subject: Re: [PATCH 1/1] block: fix potential infinite loop in the negative
 branch in __submit_bio_noacct_mq()
Message-ID: <20210324151405.GA4260@veeam.com>
References: <1616500116-3411-1-git-send-email-sergei.shtepa@veeam.com>
 <1616500116-3411-2-git-send-email-sergei.shtepa@veeam.com>
 <20210324111803.GA2687609@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210324111803.GA2687609@infradead.org>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B586D7C66
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 03/24/2021 11:18, Christoph Hellwig wrote:
> On Tue, Mar 23, 2021 at 02:48:36PM +0300, Sergei Shtepa wrote:
> > When the blk_crypto_bio_prep() function returns false, the processing
> > of the bio request must end. Repeated access to blk_crypto_bio_prep()
> > for this same bio may lead to access to already released data, since in
> > this case the bio_endio() function was already called for bio.
> > 
> > The changes allow to leave the processing of the failed bio and
> > go to the next one from the bio_list.
> > 
> > The error can only occur when using inline encryption on
> > request-based blk-mq devices and something went wrong in the
> > __blk_crypto_bio_prep().
> 
> A continue in a do { } while statement evaluates the while condition,
> so your patch is a no-op.

Thank you Christoph!
Shame on my bald head.
I apologize and will be more attentive in the future.
-- 
Sergei Shtepa
Veeam Software developer.
