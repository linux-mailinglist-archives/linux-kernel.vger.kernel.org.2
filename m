Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108E64322CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhJRP24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:28:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33806 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhJRP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:28:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CADA121966;
        Mon, 18 Oct 2021 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634570802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NIqFnwrEGJnyoSQxUbFFxHj25gl6bb413mQfbxZqMVA=;
        b=fuMUx4uiRPiMpAHFhSDyrrrRkjwIgM22udTrlrqVS75rM/Z6MvwMrHzlxnyXaG9uXaGUED
        jVLpLGM1TU8vNb8YdplGsPEhMcYdxtlJM4tB6wPUqQrB2dMSaM5Isg6Bvv0DxR1QHvCh6X
        d+eNr/ZflfeGQn/c+rH+whEX/LV7DZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634570802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NIqFnwrEGJnyoSQxUbFFxHj25gl6bb413mQfbxZqMVA=;
        b=4x39tFfZMGWfh0dGwYusAvGaTrb4s1AcOUNbI0S2TeQt4jMmWvt8ClwZ2LAClwrwMNSqEp
        EaNiibuCM3m4KgBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BB7B140A7;
        Mon, 18 Oct 2021 15:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UGUJLjCSbWFbHQAAMHmgww
        (envelope-from <colyli@suse.de>); Mon, 18 Oct 2021 15:26:40 +0000
Subject: Re: [PATCH] [v2] bcache: hide variable-sized types from uapi header
 check
To:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kmo@daterainc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210928085554.2299495-1-arnd@kernel.org>
 <ce05e90b-f22f-bd0e-4e0f-da560bffc0c2@suse.de>
 <CAK8P3a1brJNoq65h15-zZtNgwV92hwXH9p32cJpzAY3=ouOHnw@mail.gmail.com>
 <12a593bc-68bc-ac03-0307-a65a0c064af3@suse.de>
 <20211018152224.GB31195@lst.de>
From:   Coly Li <colyli@suse.de>
Message-ID: <de50010d-1424-d0e4-53f4-41b341ee68ca@suse.de>
Date:   Mon, 18 Oct 2021 23:26:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211018152224.GB31195@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 11:22 PM, Christoph Hellwig wrote:
> On Mon, Oct 18, 2021 at 10:42:37PM +0800, Coly Li wrote:
>> I am quite open for this idea. It is in uapi directory before I maintain
>> bcache. I just though the header fines on-media format should go into
>> include/uapi/, but if this is not the restricted rule, it is fine for me to
>> move this header to drivers/md/bcache/.
> Treating the on-disk definitions as a UAPI doesn't make much sense to
> me.  I like keeping it in a separate header to make clear what is the
> on-disk format and what is just in core, but it should normally live
> with the rest of the code.

Hi Christoph,

Thanks for the input. So it is fine for me to have the header in 
drivers/md/bcache.

Hi Arnd,

There is another bcache.h in drivers/md/bcache/, let me handle the 
header naming issue, and I will post a change to move the bcache.h from 
include/uapi/linux to driver/md/bcache later.
And I will ask you to help to review the change.

Coly Li
