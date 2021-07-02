Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55103BA2E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 17:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhGBPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 11:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhGBPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:47:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE4CC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=ARkV+/y7jFtj5bpl3i2a+9o76tq83T8M3zzbPUSzB9c=; b=cREEF6IegE1iuoh+j6Rv8WtUnB
        oMNl+lv+A/tbI2sF1nuDxtUk5NILjt9GBoyST02bAo7Opq1Va+TWyO7IBEDRutK2vsNNuBnHaq+q6
        dHDWflXY00EymZNvvPVUIYRHxWSbginP/NCe/1H5cXEcI6g7yc4NDQZxhfdm490DmRp6/fVpjXapj
        z2XctFFZ+UthbsWxkA+E4GSwAemPK1C3fTrgByZRIE63FokC3SNAioqfMJYCpUmxG+vQJG9sWVy+t
        YKsSYxpJkKXFD7cltF3ahS6+vO2wuDDyLit2MoJqD1++ILL45m1Uv0z48vUz7P5pTcSMthYiADffU
        k35k2CBw==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzLLL-003RMD-Lm; Fri, 02 Jul 2021 15:44:39 +0000
Subject: Re: How to reply to comments
To:     Jenny Mgeryan <jennymgeryan@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20210702070857.5049-1-jennymgeryan@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2b2ee7bf-0eea-1c84-bce5-4a11b9c8081f@infradead.org>
Date:   Fri, 2 Jul 2021 08:44:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702070857.5049-1-jennymgeryan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/21 12:08 AM, Jenny Mgeryan wrote:
> Hello everyone, I have posted an patch and I have received some comments
> from reviewers, but I do not know How to reply to them.
> thank you!
> Jenny
> 

Hi,
Could you provide a link to the patch, please?

Then someone could reply to it. That should work better IMO.

-- 
~Randy

