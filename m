Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E707B38E5A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhEXLog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhEXLoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:44:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DDEC061574;
        Mon, 24 May 2021 04:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P9kzVkpH6K+dRhisEWwKagVuKYKm8ZedPldptcbJ5EU=; b=JMI7yDmehfFgOO6K1lO8bw7rxR
        1jXqcIv4JSaz0HwjVnCJv1HPvIQk0NG4ks1n//hnn9dqPHeKcLSKRwxdqFQYaTCeXEKV6qjEyIx2N
        O8d8JkNaLZTVN5/0JthMbpwxtn7hsbsdBG4cw6IwLo49RD4kECQSZKha7QfSkRoFVQbmUvJ1+zS6B
        uJLYhyNlofZDbmeHpRZ+ltW/w4or3WE8vrkZaIJyJlvCpG0+cacFrDg3axMdRguJA79LGDiZV2gLB
        1hAD9QbIjmBQg4q68YyXWbobccjIoEeSaoG9duiWG6+vm1BOK43J3d6nvp4Bt2ZhA/1ecm6OV2J9F
        TUnCCVFg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ll8yr-002K2i-AJ; Mon, 24 May 2021 11:42:49 +0000
Date:   Mon, 24 May 2021 12:42:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] mmc: core: Use ternery for return value in
 mmc_vdd_to_ocrbitnum()
Message-ID: <YKuRNRbsHtoD4LFi@infradead.org>
References: <20210520082837.2129-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520082837.2129-1-zbestahu@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 04:28:37PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Just simplify the code.

The original version is way easier to read.
