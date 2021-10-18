Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5054143201A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhJROo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:44:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42936 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhJROo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:44:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C1FBF1FD7F;
        Mon, 18 Oct 2021 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634568165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FskdbT9rc4yhsC6Kztj9BXRX1uuBZYuwc9JfRBoPArk=;
        b=fG2OiZ2h2iVa5mox0a43QKRUyHc6ZDYJLDjPmtQrinyZK0Wy5I1wNIqTz8BJiC3PiZGX8J
        VUxJzUHvP/Q+t5JUIttrRH0CIU+wYiVRCLk+FmPbbkaoJksBkqAOXDeuqdQYIOZpMUehmQ
        gUga6E7JvAcIXWC0C8xzgPpt8F2vhD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634568165;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FskdbT9rc4yhsC6Kztj9BXRX1uuBZYuwc9JfRBoPArk=;
        b=jGvaIxbndbmPkne573YeeB9r1iBODD7o4pJSR40VItRuItpXb5BKivdfC9O8EEXNCWca54
        ld5uc+H7rshU5YAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4784414090;
        Mon, 18 Oct 2021 14:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V3rrAeGHbWG9BgAAMHmgww
        (envelope-from <colyli@suse.de>); Mon, 18 Oct 2021 14:42:41 +0000
Subject: Re: [PATCH] [v2] bcache: hide variable-sized types from uapi header
 check
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kmo@daterainc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20210928085554.2299495-1-arnd@kernel.org>
 <ce05e90b-f22f-bd0e-4e0f-da560bffc0c2@suse.de>
 <CAK8P3a1brJNoq65h15-zZtNgwV92hwXH9p32cJpzAY3=ouOHnw@mail.gmail.com>
From:   Coly Li <colyli@suse.de>
Message-ID: <12a593bc-68bc-ac03-0307-a65a0c064af3@suse.de>
Date:   Mon, 18 Oct 2021 22:42:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1brJNoq65h15-zZtNgwV92hwXH9p32cJpzAY3=ouOHnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 10:39 PM, Arnd Bergmann wrote:
> On Mon, Oct 18, 2021 at 4:20 PM Coly Li <colyli@suse.de> wrote:
>> IMHO, remove bcache related header from uapi check might be better
>> solution. So far only bcache-tools uses this header with its own copy,
>> no application includes the header(s) so far. It makes sense to exclude
>> bcache.h from upai headers check.
> Should we just move it to include/linux/ and out of the uapi headers entirely
> then? It sounds like it's not actually an ABI but just the definition of the
> data layout that is not included by anything from user space.
>
> We are a bit inconsistent here already, e.g. btrfs has all its structures
> in uapi, but ext4 does not.

I am quite open for this idea. It is in uapi directory before I maintain 
bcache. I just though the header fines on-media format should go into 
include/uapi/, but if this is not the restricted rule, it is fine for me 
to move this header to drivers/md/bcache/.

Coly Li
