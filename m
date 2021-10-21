Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9243600F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhJULTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhJULTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:19:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2314C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VyH5ywSiW/7Isy9TxEdW6GuCapIoEP7S5itLkyGmeD4=; b=08Sg9xRN4pNy2S24Xgfphq+rBW
        fuupD+ABSSyMV8mboFL1rS2+ZJBz/rW+Vuo9MTa2huzNPpSc24z3ge8IejiNxVowGM6uMOMiBi1UM
        P/kbYoaBWpWOC6YrVxFbNZujUY42xT+wPuFC7A5JNbb1+wgnrSPwRC4097s7CP8U9hi+ouaQ8uad8
        fahluK771dybLMYL6saStQvFLObmRMROY/NUlLGxQiTd0VpNUe9EON7Yw/TLnnMGTXiLjWBNiKNJc
        8mv3xXSQcyCU3mlVbTPv2tf5BmX8cjNMYUw2pdjKXG0oOWVukClSWZjeLhDBQd+eBMS9NumdE2Noi
        fHziKAyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdW44-007K5H-J6; Thu, 21 Oct 2021 11:16:52 +0000
Date:   Thu, 21 Oct 2021 04:16:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Manjong Lee <mj0123.lee@samsung.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, nanich.lee@samsung.com,
        yt0928.kim@samsung.com, junho89.kim@samsung.com,
        jisoo2146.oh@samsung.com
Subject: Re: [PATCH 1/1] mm: bdi: Initialize bdi_min_ratio when bdi unregister
Message-ID: <YXFMJJ3u+x34iNy0@infradead.org>
References: <CGME20211021072307epcas1p4aa4388c13e71a66e3e1d5f7ee68b5a7f@epcas1p4.samsung.com>
 <20211021161942.5983-1-mj0123.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021161942.5983-1-mj0123.lee@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 01:19:43AM +0900, Manjong Lee wrote:
> Because when sdcard is removed, bdi_min_ratio value will remain.
> Currently, the only way to reset bdi_ min_ratio is to reboot.

But bdis that are unregistered are never re-registered.  What is
the problem you're trying to solve?
