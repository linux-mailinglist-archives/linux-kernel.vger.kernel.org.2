Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F34459BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhKWFpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhKWFpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:45:12 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13FFC061574;
        Mon, 22 Nov 2021 21:42:04 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id de30so20771534qkb.0;
        Mon, 22 Nov 2021 21:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T6Ehd/Lfx371MUNw04rBhKN/sG8reZR2bebigA/LxqQ=;
        b=ROMltAut/hpf7NQpyZFqkDyceq2F3m3BN58uYQiIavaOB0lxFZENPgxHc58ytovpKw
         6gt+pnnspwNk2E3QGwjS3Y9NZKMkEyR8KdScBQUHzBwjwP0DgahUJpYokwovWuDYIMWu
         8XCraQnSHhHug6Pe3O8KctKvyQ5alpsDu8L2v9Iuy8H+bFa2PSImWNblg9lY9TCdruQK
         kwi/UikeSy9EUY4X0fXVg5l24bTsYSnOjR0Z29UQ+I5vBpRpJ5OopP7cEjR2aH7EmetK
         xgR29QJLWQpqXsTwCwftWXmNsQ+YRWjfe42RPXzp5JDcYHLXKVurEwNp+HxQBZZAmy53
         FN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T6Ehd/Lfx371MUNw04rBhKN/sG8reZR2bebigA/LxqQ=;
        b=UD/rcNn2H4ximtiVzuMf8n1tX3eeFByVVC+uC1bkzkeIlZ4CFWpAOvpPn4Y0ijXAjh
         OXiiHrl3wlojyzlU0l1FR2pN2p/wYkRIm37iOx+x3ci6mE8Zqt+C4zd0WmOLYdwY1nYk
         g4hn0PuSow49lNMFI1sP0FM6k1GSMLSQXP0Str8nmNWz9myeyfIZqwOf5DuDe3lvC/Jj
         UP8qkm9b8yg47OVAbesSdgTJA3yKajE9Fl4XFAJ90k10YWrvpACNcCcjoT4hYJkzn1gz
         5SbyRF3LfLJMYEABNZyMcK9ITluxUenPOyrWwblEkpmo6WzgL/ERA/Sq6zEYSC572oDf
         R5/w==
X-Gm-Message-State: AOAM532OHrj/7t4LTrxkdnaoqjPihptwpaMQq82v9CjW1rnpz7JwQTka
        U2WyzUoW/Pe11KefCny6a1k=
X-Google-Smtp-Source: ABdhPJxnL1mYYM4u0vjnSKKAyL+GqXM2yAvZy6ORYVxEamnwXpGl3hXazMm30JT8kUBF41f2mM4bew==
X-Received: by 2002:a37:644f:: with SMTP id y76mr2265214qkb.244.1637646124059;
        Mon, 22 Nov 2021 21:42:04 -0800 (PST)
Received: from [192.168.43.249] (mobile-166-172-187-125.mycingular.net. [166.172.187.125])
        by smtp.gmail.com with ESMTPSA id f21sm5795389qte.52.2021.11.22.21.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 21:42:03 -0800 (PST)
Subject: Re: [PATCH v2] of: base: Skip CPU nodes with "fail"/"fail-..." status
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211122114536.2981-1-matthias.schiffer@ew.tq-group.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <151232b7-6f82-c4df-1fa9-da673e3bae0e@gmail.com>
Date:   Tue, 23 Nov 2021 00:42:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211122114536.2981-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/21 6:45 AM, Matthias Schiffer wrote:
> Allow fully disabling CPU nodes using status = "fail".
> 
> This allows a bootloader to change the number of available CPUs (for
> example when a common DTS is used for SoC variants with different numbers
> of cores) without deleting the nodes altogether, which could require
> additional fixups to avoid dangling phandle references.
> 
> Unknown status values (everything that is not "okay"/"ok", "disabled" or
> "fail"/"fail-...") will continue to be interpreted like "disabled",
> meaning that the CPU can be enabled during boot.
> 

Thank you for including all the references!  I find them helpful.

> References:
> - https://www.lkml.org/lkml/2020/8/26/1237

That reference should be:
  https://lore.kernel.org/all/CAL_Jsq+1LsTBdVaODVfmB0eme2jMpNL4VgKk-OM7rQWyyF0Jbw@mail.gmail.com/

Rob might be willing to fix that himself without a new patch version.

> - https://www.spinics.net/lists/devicetree-spec/msg01007.html

The following reference is the pull request for the devicetree specification
change that is provided in the previous reference.  I wouldn't include this
in the commit, but maybe Rob will.

> - https://github.com/devicetree-org/dt-schema/pull/61
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: Treat unknown status values like "disabled", not like "fail"
> 
> 
>  drivers/of/base.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 61de453b885c..5b907600f5b0 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -650,6 +650,28 @@ bool of_device_is_available(const struct device_node *device)
>  }
>  EXPORT_SYMBOL(of_device_is_available);
>  
> +/**
> + *  __of_device_is_fail - check if a device has status "fail" or "fail-..."
> + *
> + *  @device: Node to check status for, with locks already held
> + *
> + *  Return: True if the status property is set to "fail" or "fail-..." (for any
> + *  error code suffix), false otherwise
> + */
> +static bool __of_device_is_fail(const struct device_node *device)
> +{
> +	const char *status;
> +
> +	if (!device)
> +		return false;
> +
> +	status = __of_get_property(device, "status", NULL);
> +	if (status == NULL)
> +		return false;
> +
> +	return !strcmp(status, "fail") || !strncmp(status, "fail-", 5);
> +}
> +
>  /**
>   *  of_device_is_big_endian - check if a device has BE registers
>   *
> @@ -796,6 +818,9 @@ EXPORT_SYMBOL(of_get_next_available_child);
>   * of_get_next_cpu_node - Iterate on cpu nodes
>   * @prev:	previous child of the /cpus node, or NULL to get first
>   *
> + * Unusable CPUs (those with the status property set to "fail" or "fail-...")
> + * will be skipped.
> + *
>   * Return: A cpu node pointer with refcount incremented, use of_node_put()
>   * on it when done. Returns NULL when prev is the last child. Decrements
>   * the refcount of prev.
> @@ -817,6 +842,8 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
>  		of_node_put(node);
>  	}

This comment is being really picky.  I would put the check for status value
of fail after the check of node name.  If Rob is willing to accept this
version I am ok with it.

>  	for (; next; next = next->sibling) {
> +		if (__of_device_is_fail(next))
> +			continue;
>  		if (!(of_node_name_eq(next, "cpu") ||
>  		      __of_node_is_type(next, "cpu")))
>  			continue;
> 

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
