Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF5401826
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 10:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbhIFIlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 04:41:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34988 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhIFIlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:41:11 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F9F2220FB;
        Mon,  6 Sep 2021 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630917606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xepuq2g1UzpFTzC0FV5yi43ZLpLb8aMqI7nbH2laTl8=;
        b=enIQailCj0QG3GmZKHJQ/HdvNX+3DVhiYocJMKVxVVrW4wCw0yUhEluAEBZCYToEalVE9u
        8y5tr6BKNQn1dolhvVjPE/kVMcZDquknnPmWSqwjlMM3wOmFTldLyiIDX79ZddBj0qlOiY
        kCOvsRWtpkzxN4VIOIAraIWj0HMqnv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630917606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xepuq2g1UzpFTzC0FV5yi43ZLpLb8aMqI7nbH2laTl8=;
        b=xarIDKwLIHfLikmp7p97wQPLMuG55G1Eqt1tNGzIk/RW6STFT3eabuFmtKE25RDjDEGAdc
        MvsEUQ1VlhGFzqBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7A14113299;
        Mon,  6 Sep 2021 08:40:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id RFIaHObTNWEycQAAGKfGzw
        (envelope-from <hare@suse.de>); Mon, 06 Sep 2021 08:40:06 +0000
Subject: Re: [PATCH v2] nvme: avoid race in shutdown namespace removal
To:     Christoph Hellwig <hch@infradead.org>,
        Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
References: <20210902092002.67614-1-dwagner@suse.de>
 <YTXKwOvCtJOHnhpu@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d63a15af-63a7-3fa0-1559-4518dee3a99a@suse.de>
Date:   Mon, 6 Sep 2021 10:40:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YTXKwOvCtJOHnhpu@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 10:01 AM, Christoph Hellwig wrote:
> On Thu, Sep 02, 2021 at 11:20:02AM +0200, Daniel Wagner wrote:
>> When we remove the siblings entry, we update ns->head->list, hence we
>> can't separate the removal and test for being empty. They have to be
>> in the same critical section to avoid a race.
>>
>> To avoid breaking the refcounting imbalance again, add a list empty
>> check to nvme_find_ns_head.
> 
> Hannes, can you look over this and run your tests on it?
> 
I'm at it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
