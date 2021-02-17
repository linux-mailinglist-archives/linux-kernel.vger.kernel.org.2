Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF10531DCB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhBQPvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhBQPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:50:36 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FD1C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:49:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v62so4050005wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vyIz6XzbeaNCCfCuuD+2mwRTt6br0jc9ZpAqiPSLHBI=;
        b=fdm/+1aAXgcX3VNEVSWNSNwU5smLpnydMyFDodUCVHoapRhjtEnrMuU2y8HZcghVSK
         /gqhQSKX3EFMKrdoY3t5ivRhZUxmbUjk9nvA3AqXtXUmenp3ewzLt8ahJlm+2/Do/cut
         Ao8rfCh4p72EwVvbkTxjIYEdiJcp+1BHN3ais=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vyIz6XzbeaNCCfCuuD+2mwRTt6br0jc9ZpAqiPSLHBI=;
        b=T+tWxTF5SSiPbt6f0C6X8uegVfw2LJFekvOWw4CQy5cQXG8AO4/88CmyDkiM77Qlj8
         1Ma/U494RUwvIOYfnUxZtMhUpa0oNyrncf2fXW+3zU9PPgkq4CzHAMwtTL5nj8TxwMnz
         1NFafcbyB503yAKCy7ze4PdhNlKPErYn4Qsr2aB6JramtO8skpUeaD812vxX++yvrKMw
         P73xrBqECQ8FEVSbyoEL8vSshuIhGE9+lz8JwIzFwx0IZ6wCd8MG+0/czv0fVy64cdIe
         ph+5QWH3GtM5KwaD8WVdGF2h+iEgxTX2kRC7npehxJWD9G2wZNergsGWADdYOYIGVnqS
         vQeg==
X-Gm-Message-State: AOAM531+O44muoN3tqV22XXYW1rm0Mav6XHeIyov9qb8jXRzDKVPUVmH
        udiFCR2VGN5vZlUNx1PaHHgTBg==
X-Google-Smtp-Source: ABdhPJw4GD5+t9hg0pYMTFUui9uhu9unEJ2d7e6wDarWTJw34Ws80afxoENQduB8QeZ2zamLBjpAWA==
X-Received: by 2002:a1c:bcc3:: with SMTP id m186mr7543013wmf.165.1613576994841;
        Wed, 17 Feb 2021 07:49:54 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:76fd])
        by smtp.gmail.com with ESMTPSA id v204sm3622000wmg.38.2021.02.17.07.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 07:49:54 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:49:54 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: debugfs: was: Re: [PATCH v4] printk: Userspace format
 enumeration support
Message-ID: <YC07IszYreU0mUn5@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCvsGzv3qlsWU+UE@alley>
 <YCv+gpVGHTh9ZMNq@chrisdown.name>
 <YC03xnsB8586agnT@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YC03xnsB8586agnT@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>> > > +	debugfs_remove(ps->file);
>> >
>> > IMHO, we should remove the file before we remove the way how
>> > to read it. This should be done in the opposite order
>> > than in store_printk_fmt_sec().
>>
>> There is a subtle issue with doing this as-is: debugfs_remove(ps->file)
>> cannot be called under printk_fmts_mutex, because we may deadlock due to a
>> pinned debugfs refcnt if debugfs_remove() and _show happen at the same time.
>
>Do we need to call debugfs_remove(ps->file) under printk_fmts_mutex?

Ah, my concern was simultaneous entries into remove_printk_fmt_sec (which would 
require setting a separate flag under the mutex), but now I think about it, the 
module notifier synchronously waits, so that can't happen anyway.

As such it should be safe to just do:

remove()
{
	mutex_lock(&printk_fmts_mutex);
	ps = find_printk_fmt_sec();
	mutex_unlock(&printk_fmts_mutex);

	if (!ps)
		return;

	/* waits for _show */
	debugfs_remove(ps->file);

	mutex_lock(&printk_fmts_mutex);
	/* Do the data structure teardown */
	mutex_unlock(&printk_fmts_mutex);
}

Sounds good to me, I'll do that for v5. Thanks! :-)
