Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0CE4270FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbhJHSyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbhJHSxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:53:46 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26C1C061755;
        Fri,  8 Oct 2021 11:51:49 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a16so6996489qvm.2;
        Fri, 08 Oct 2021 11:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5OFGDuHzExZ6YP988U4dV7DWZHlKPehmZBF+7HQaBd4=;
        b=Qbr3DjwRQJiFCz/iZijzIywpO9gCHA83P1c+1KydCmVze/r0EwFdTeeu24sNlZX96O
         9A+DS6Cpvkt6iHDlPpkFmu/XxP96aZ3ba9QTR/InvaMd0U/3rWghVRbmJ8ONFjxF6md8
         l3j4fQoOYxHp5mkDrlrUxsBUdknMPJQzVTk55BhwbtsbZzhMyIjfTeZCzZVyEqb5oXwz
         0vcV/vatVoyMPUNl0xtLA6iyd6DHt2wRvGGZecH3X6V/2PtrPeOCYomGDGXaToYT7jMG
         OSU0DOQWpz1hfkxuB5Ac9Id6wmDDe6piU/MLnzS3VyrcQs9MCTQY8+Y3qvOhBaM8ywHm
         r2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5OFGDuHzExZ6YP988U4dV7DWZHlKPehmZBF+7HQaBd4=;
        b=qZq7A3cjZS0vhDHu5PUbWnUWbHxzWY1liEr4ueJqaGKqpfDV7uIQy9JqP8V939geIo
         tNqrDczoBmxcQ3VM7R3qFprQ6cpgkSqrghC4iqtGI6z9lVliVNXemMDLYy2pQPLWZrON
         leQOpO1WkvB9BqEJzE3+gHbhYYhG/4eDV1RIXqACKBJoqfGROUfMbiqwMELhVD1eGIYW
         LnRdI7acSwL0eIDT4qVX7DfbM2Cwn/lkvpo6m15o59pKcdta9F5EEaQALl2B8tWzBCut
         oVzfbT5CwbT4qu9RD7N3SZ/bkNFj5XaKus6ghTpQ2SeJiMy88vXt3asIn/eUIRr8X2PD
         SZ5w==
X-Gm-Message-State: AOAM530Q7HqX3CSy6Ri+RTzKHjwV7o4q07fcKRcBZVl/bDqFG0B6iViV
        eZ36ThPSBGIyCM/dU/IfaMLGVSQG7K0=
X-Google-Smtp-Source: ABdhPJwIdJPfZHh0U1VqbIp0YlYn56ZGOs1BCLi+ARFJUQB0lk32U3CgXOpqvhg+L8Lj33UkotzwYg==
X-Received: by 2002:a0c:b4c9:: with SMTP id h9mr11768089qvf.6.1633719108780;
        Fri, 08 Oct 2021 11:51:48 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id p190sm175319qkf.15.2021.10.08.11.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 11:51:48 -0700 (PDT)
Subject: Re: [PATCH 6/9] of: add support for 'dynamic' DT property
To:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <20211007000954.30621-7-zev@bewilderbeest.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <7bf5cfce-e84d-f0e8-e6e8-8e6fedffd154@gmail.com>
Date:   Fri, 8 Oct 2021 13:51:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211007000954.30621-7-zev@bewilderbeest.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 7:09 PM, Zev Weiss wrote:
> Nodes marked with this (boolean) property will have a writable status
> sysfs file, which can be used to toggle them between "okay" and
> "reserved", effectively hot-plugging them.  Note that this will only
> be effective for devices on busses that register for OF reconfig
> notifications (currently spi, i2c, and platform), and only if
> CONFIG_OF_DYNAMIC is enabled.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/of/kobj.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
> index 378cb421aae1..141ae23f3130 100644
> --- a/drivers/of/kobj.c
> +++ b/drivers/of/kobj.c
> @@ -36,6 +36,69 @@ static ssize_t of_node_property_read(struct file *filp, struct kobject *kobj,
>  	return memory_read_from_buffer(buf, count, &offset, pp->value, pp->length);
>  }
>  
> +static ssize_t of_node_status_write(struct file *filp, struct kobject *kobj,
> +                                    struct bin_attribute *bin_attr, char *buf,
> +                                    loff_t offset, size_t count)
> +{
> +	int rc;
> +	char *newstatus;
> +	struct property **deadprev;
> +	struct property *newprop = NULL;
> +	struct property *oldprop = container_of(bin_attr, struct property, attr);
> +	struct device_node *np = container_of(kobj, struct device_node, kobj);
> +
> +	if (WARN_ON_ONCE(strcmp(oldprop->name, "status")))
> +		return -EIO;
> +
> +	if (offset)
> +		return -EINVAL;
> +
> +	if (sysfs_buf_streq(buf, count, "okay") || sysfs_buf_streq(buf, count, "ok"))
> +		newstatus = "okay";
> +	else if (sysfs_buf_streq(buf, count, "reserved"))
> +		newstatus = "reserved";
> +	else if (sysfs_buf_streq(buf, count, "disabled"))
> +		newstatus = "disabled";
> +	else
> +		return -EINVAL;
> +
> +	if (!strcmp(newstatus, oldprop->value))
> +		return count;
> +

If the general approach of this patch set is the correct way to provide the desired
functionality (I'm still pondering that), then a version of the following code
probably belongs in drivers/of/dynamic.c so that it is easier to maintain and keep
consistent with other dynamic devicetree updates.  If you look at the code there
that touches deadprops (eg __of_changeset_entry_apply()) you will notice that the
locking issues are more extensive than what is implemented here.

I'm still thinking about how this interacts with other forms of dynamic devicetree
changes (eg drivers/of/dynamic.c and also overlays).

> +	/*
> +	 * of_update_property_self() doesn't free replaced properties, so
> +	 * rifle through deadprops first to see if there's an equivalent old
> +	 * status property we can reuse instead of allocating a new one.
> +	 */
> +	mutex_lock(&of_mutex);
> +	for (deadprev = &np->deadprops; *deadprev; deadprev = &(*deadprev)->next) {
> +		struct property *deadprop = *deadprev;
> +		if (!strcmp(deadprop->name, "status") &&
> +		    deadprop->length == strlen(newstatus) + 1 &&
> +		    !strcmp(deadprop->value, newstatus)) {
> +			*deadprev = deadprop->next;
> +			deadprop->next = NULL;
> +			newprop = deadprop;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&of_mutex);
> +
> +	if (!newprop) {
> +		newprop = kzalloc(sizeof(*newprop), GFP_KERNEL);
> +		if (!newprop)
> +			return -ENOMEM;
> +
> +		newprop->name = oldprop->name;
> +		newprop->value = newstatus;
> +		newprop->length = strlen(newstatus) + 1;
> +	}
> +
> +	rc = of_update_property_self(np, newprop, true);

-Frank

> +
> +	return rc ? rc : count;
> +}
> +
>  /* always return newly allocated name, caller must free after use */
>  static const char *safe_name(struct kobject *kobj, const char *orig_name)
>  {
> @@ -79,6 +142,12 @@ int __of_add_property_sysfs(struct device_node *np, struct property *pp)
>  	pp->attr.size = secure ? 0 : pp->length;
>  	pp->attr.read = of_node_property_read;
>  
> +	if (!strcmp(pp->name, "status") && of_property_read_bool(np, "dynamic")) {
> +		pp->attr.attr.mode |= 0200;
> +		pp->attr.write = of_node_status_write;
> +		pp->attr.growable = true;
> +	}
> +
>  	rc = sysfs_create_bin_file(&np->kobj, &pp->attr);
>  	WARN(rc, "error adding attribute %s to node %pOF\n", pp->name, np);
>  	return rc;
> 

