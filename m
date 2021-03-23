Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFD3346B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhCWWEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbhCWWD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:03:56 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41633C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:03:56 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c4so16105790qkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=f9Uq3XPpmlgltCRhfVyth1crnNqB1PwbcPkWKy7CQp0=;
        b=irrr9DNl5oEXkt990dnROFD3G4dgkAPMDDe+Xokv1cP/sJg8W4BpYbpmRBJqXRK/9s
         L42rcpcpz4Sr55hg4m8M7WdNYWHWoSFkwOJhv4nnGKTMSB9kPfjRFAn/zulItL1jkF6V
         UbAi6nP7O/PYI0SV/E6fqrSb3KCW8J/iEHYdgPZ/tmexH126GtPpvubahVCynGGGD15+
         GkO/XueuqIbkv+xgmAdSjxXFZv4eZAMiC7sqS2DbHQshycqWduuwq2IAlTThJqsz/6jp
         u05oxHUrZ31fbGFT5hbTFnnFmZLkzn85YP8uLUNHK5kOGi5NBA8FdloY7p5hr2ZBDAOs
         WuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=f9Uq3XPpmlgltCRhfVyth1crnNqB1PwbcPkWKy7CQp0=;
        b=GilAAm/MytNwIcp77h6qeyHAqHfITCCIg5Etg7TxnehEtF2XGDeN5SDWV+ffxf8bnA
         sDko3/YZOqZPpMaBESo4VNV8F4QvqD9OVJR6CfDm+GB2vWcW1pFLGclg6XufS4ekPQvG
         1pXvA97c3vinaaL12dmCi7qwd6OCI3vVd5ZzaJCP//IHeYf+cxlSvOn6DL8nB44CDsd7
         EKMYS9gDZg0A+2yXBJSNokEQW1YXIV5OqDMOTJLfk9uwuGjyGGmeORH1zOp3uB8ZUFyW
         qdIquhKKFHOwz9LypkpHAxylHAHuLBObY+rZEh/Xid9mV8d5dziE/mPr8vTZW1GPLjVF
         QPvg==
X-Gm-Message-State: AOAM531Ja+H7XDNh1OZI2GbihvewFBc1iY+t0U/qAQeLT++6taAaMQCG
        2jloJxr+olGpK0eln0iQtvFp/D57wPRCDvHa
X-Google-Smtp-Source: ABdhPJxeVGYQXhX6jqZurlKZDaw/Z4ti98wrhy42voheAUO7eykFoUg7ijcAy7fmy0G7X8pYwD/Q7Q==
X-Received: by 2002:a05:620a:118f:: with SMTP id b15mr183992qkk.5.1616537034525;
        Tue, 23 Mar 2021 15:03:54 -0700 (PDT)
Received: from Slackware ([37.19.198.86])
        by smtp.gmail.com with ESMTPSA id o23sm178672qtm.31.2021.03.23.15.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:03:53 -0700 (PDT)
Date:   Wed, 24 Mar 2021 03:35:42 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Trivial typo fixes
Message-ID: <YFpmNjPnsaDlTuoB@Slackware>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
References: <20210323203317.31944-1-unixbhaskar@gmail.com>
 <c9589765-b5cd-7cb5-4af5-2f7760a0a7a0@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uTT4n9JFT1mm9czE"
Content-Disposition: inline
In-Reply-To: <c9589765-b5cd-7cb5-4af5-2f7760a0a7a0@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uTT4n9JFT1mm9czE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:53 Tue 23 Mar 2021, Randy Dunlap wrote:
>On 3/23/21 1:33 PM, Bhaskar Chowdhury wrote:
>> Trivial spelling fixes.
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>Ingo has already fixed all of these.
>Plus many more that are trace-related.
>
Okay, Nevermind.
>> ---
>>  kernel/trace/trace_seq.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
>> index 1d84fcc78e3e..e03eae7a5577 100644
>> --- a/kernel/trace/trace_seq.c
>> +++ b/kernel/trace/trace_seq.c
>> @@ -12,11 +12,11 @@
>>   * This will set up the counters within the descriptor. You can call
>>   * trace_seq_init() more than once to reset the trace_seq to start
>>   * from scratch.
>>   * The buffer size is currently PAGE_SIZE, although it may become dynamic
>>   * in the future.
>>   *
>> - * A write to the buffer will either succed or fail. That is, unlike
>> + * A write to the buffer will either succeed or fail. That is, unlike
>>   * sprintf() there will not be a partial write (well it may write into
>>   * the buffer but it wont update the pointers). This allows users to
>>   * try to write something into the trace_seq buffer and if it fails
>> @@ -73,7 +73,7 @@ int trace_print_seq(struct seq_file *m, struct trace_seq *s)
>>   * @fmt: printf format string
>>   *
>>   * The tracer may use either sequence operations or its own
>> - * copy to user routines. To simplify formating of a trace
>> + * copy to user routines. To simplify formatting of a trace
>>   * trace_seq_printf() is used to store strings into a special
>>   * buffer (@s). Then the output may be either used by
>>   * the sequencer or pulled into another buffer.
>> @@ -133,7 +133,7 @@ EXPORT_SYMBOL_GPL(trace_seq_bitmask);
>>   * @fmt: printf format string
>>   *
>>   * The tracer may use either sequence operations or its own
>> - * copy to user routines. To simplify formating of a trace
>> + * copy to user routines. To simplify formatting of a trace
>>   * trace_seq_printf is used to store strings into a special
>>   * buffer (@s). Then the output may be either used by
>>   * the sequencer or pulled into another buffer.
>> @@ -226,7 +226,7 @@ EXPORT_SYMBOL_GPL(trace_seq_puts);
>>   * @c: simple character to record
>>   *
>>   * The tracer may use either the sequence operations or its own
>> - * copy to user routines. This function records a simple charater
>> + * copy to user routines. This function records a simple character
>>   * into a special buffer (@s) for later retrieval by a sequencer
>>   * or other mechanism.
>>   */
>> @@ -348,7 +348,7 @@ int trace_seq_path(struct trace_seq *s, const struct path *path)
>>  EXPORT_SYMBOL_GPL(trace_seq_path);
>>
>>  /**
>> - * trace_seq_to_user - copy the squence buffer to user space
>> + * trace_seq_to_user - copy the sequence buffer to user space
>>   * @s: trace sequence descriptor
>>   * @ubuf: The userspace memory location to copy to
>>   * @cnt: The amount to copy
>> --
>
>
>--
>~Randy
>

--uTT4n9JFT1mm9czE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBaZjIACgkQsjqdtxFL
KRVIcQf/ce0mMMqTXTPKYWnvLHDO/QUFEbx38Vg9WPMAdNWdaveks5MkKmbDkj9H
okoVOpnm04/hDYtZvgLbJiEW5JeA+lRDJX8ov+6hKVjnzNKVQACmedwlQ3xbUE8a
J0tG01pOja9+IIkLwGgOcf7A8rapF6SNXl8KBsBJGhQFIrskZZa3DT7kjO+8esyE
Z2CJbTf4Ltz+2PVi+B+Q479tb3Pmjo4uPTXVv8719YBqngvVXRm6dt+EJAnceDif
XhTs8ZTg7xLO6xHYaegyXgtSOQAZQDAwcAlHuP+QawMudQsktBfqakPL77q6fkiX
4DZi2u8tcd2nNsbWANV5Sf4uT/oCVg==
=9v9E
-----END PGP SIGNATURE-----

--uTT4n9JFT1mm9czE--
