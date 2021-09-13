Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6406E408415
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhIMFxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhIMFxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:53:22 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3450C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 22:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=vtaezEpuChMS+Oo1QVXwXwmiKHZuiMo9XcUhnaQIgpg=; b=qhO8lgCmvby0mjswaGg7W40eyx
        dGlHWEkApirFLVZTmKA0mWg0/MWIRQ1kXm4I5SRrEJ7OTDKwgw9sAe5ZGZMFxMp+0CXBgUV7zor6n
        25UmEEsVDlpBwAYu9LlsuPHYJweZp2XstP5eQknLw8dy+o6MJNTpzBW3xeocCYrPyi5/QHgs4O/Hi
        O9JQcikQpxo00ctVD/fqxnl+TPpHnYwWEPVAiU1UDo9inNwOgfLwKa/5YnG1xW0SrTLqj2yj9pndj
        EeqAa+ExjGb4cPY1AGUdDgyLnLCxgO7y49WcJxzZkJAAHAbcfLUnBWAdmXZ2MmeiUzx+h+Xcv4Blp
        SPdtGiig==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPesv-000Kul-9h; Mon, 13 Sep 2021 05:52:05 +0000
Subject: Re: h8300 pull request for 5.14-rc?
To:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>
References: <20210913054915.GA3631@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <25fc5ea6-b7b7-6d75-5550-590b2ce35291@infradead.org>
Date:   Sun, 12 Sep 2021 22:52:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913054915.GA3631@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/21 10:49 PM, Christoph Hellwig wrote:
> Hi Yoshinori-san,
> 
> what happened to the h8300 pull request with the set_fs() removal that
> is in linux-next?
> 

Rich Felker says that he will look into handling the arch/sh/ patches.

https://lore.kernel.org/lkml/20210912015740.GJ13220@brightrain.aerifal.cx/

-- 
~Randy

