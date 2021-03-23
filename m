Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AA434539D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCWAGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhCWAGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:06:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE84C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:06:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so11412574pjc.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YrwTxM1JRhwCBImEEMiXrWUueuGP8y0gV5ZRW5L/A0w=;
        b=AJK6iy9YZIVcsFMyZdM9/n2Nq0jYRLcbLu0OgwUd6kWoGdYixeRnX91zceByThB+qg
         1O9QBmew16jSEs3tCZj/VvWo4XFFHqr29XVTBN8INs9MAV1j69hzmrerT3ouIxnYD54Z
         wl2MsvF3QF/MbjAbrMzOV+q/Tyj/tgJMdUMDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YrwTxM1JRhwCBImEEMiXrWUueuGP8y0gV5ZRW5L/A0w=;
        b=bdtC7fc0xSz1N15OKu8pVdGwP4bDMZ7n/rtVRIWyKvjFqmS84UNly2TcMNx8LWAOMB
         ts4vVEhqofoMSP6AJ263r4+WSOsSoulGDbIvWG2bxT0JB0zF2SvsMvKiaNLOsSPcjQFL
         8CYzaYXf50LpazXBkBKA8J0mwz1aXJ/6YfyuTIGd8/zwjLmx3QCsShrrkzZUpZTBuyjv
         6OWKsjpUeJfZ1c4wUL501Xs+AugZzSJNPbVr/n3OI2MsByENikqCH6GhuYo0rd9cIFLQ
         lY4tnSoVycNMuxsofCjI/t43IWZIq/OIpNAfEEeXijmkiNqIatCI+Tne6sAbWgpC/gGe
         64sA==
X-Gm-Message-State: AOAM53069fhK2omCh2NsR2zJil4bBzdZbZFo2mYHHW8vmw2pBlJ3L57z
        cEfmJo3JfzH5YuS1hIhULTfsew==
X-Google-Smtp-Source: ABdhPJzi4JptaWSjZ+IpPh95R3QM3rbCmXAkIDW3AERR+GPKvu25DYfOuw1jEE+qkDYTJZUnMG4TkA==
X-Received: by 2002:a17:90a:7c4b:: with SMTP id e11mr1510708pjl.151.1616457959673;
        Mon, 22 Mar 2021 17:05:59 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:bcf2:e05a:a993:9494])
        by smtp.gmail.com with ESMTPSA id t22sm493650pjw.54.2021.03.22.17.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:05:59 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:05:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        hyc.lee@gmail.com, viro@zeniv.linux.org.uk, hch@lst.de,
        hch@infradead.org, ronniesahlberg@gmail.com,
        aurelien.aptel@gmail.com, aaptel@suse.com, sandeen@sandeen.net,
        dan.carpenter@oracle.com, colin.king@canonical.com,
        rdunlap@infradead.org, Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 3/5] cifsd: add file operations
Message-ID: <YFkw3yabfNCXuO05@google.com>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
 <20210322051344.1706-4-namjae.jeon@samsung.com>
 <20210322081512.GI1719932@casper.infradead.org>
 <YFhdWeedjQQgJdbi@google.com>
 <20210322170916.GS1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322170916.GS1719932@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/22 17:09), Matthew Wilcox wrote:
> On Mon, Mar 22, 2021 at 06:03:21PM +0900, Sergey Senozhatsky wrote:
> > On (21/03/22 08:15), Matthew Wilcox wrote:
> > > 
> > > What's the scenario for which your allocator performs better than slub
> > > 
> > 
> > IIRC request and reply buffers can be up to 4M in size. So this stuff
> > just allocates a number of fat buffers and keeps them around so that
> > it doesn't have to vmalloc(4M) for every request and every response.
> 
> Hang on a minute, this speaks to a deeper design problem.  If we're doing
> a 'request' or 'reply' that is that large, the I/O should be coming from
> or going to the page cache.  If it goes via a 4MB virtually contiguous
> buffer first, that's a memcpy that could/should be avoided.

But huge vmalloc buffers are still needed. For instance, `ls -la` in
a directory with a huge number of entries.

> But now i'm looking for how ksmbd_find_buffer() is used, and it isn't.
> So it looks like someone came to the same conclusion I did, but forgot
> to delete the wm code.

Yes, I think it's disabled by default and requires some smb.conf
configuration. So I guess that wm code can be removed. Especially given
that

> That said, there are plenty of opportunities to optimise the vmalloc code,
> and that's worth pursuing.

That would be really interesting to see!

> And here's the receive path which contains
> the memcpy that should be avoided (ok, it's actually the call to ->read;
> we shouldn't be reading in the entire 4MB but rather the header):

> +		conn->request_buf = ksmbd_alloc_request(size);
> +		if (!conn->request_buf)
> +			continue;
> +
> +		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
> +		if (!ksmbd_smb_request(conn))
> +			break;
> +
> +		/*
> +		 * We already read 4 bytes to find out PDU size, now
> +		 * read in PDU
> +		 */
> +		size = t->ops->read(t, conn->request_buf + 4, pdu_size);


// A side note, it seems that the maximum read/write/trans buffer size that
// windows supports is 8MB, not 4MB.
