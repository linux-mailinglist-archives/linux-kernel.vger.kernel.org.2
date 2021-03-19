Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2791034133F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 03:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhCSCzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231617AbhCSCyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616122489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85NCWAxa1jVzqqnNBtK+hmLDEKyKBKvSfo347Q2/IPc=;
        b=AGMj3ElPM4PAUZJRwMt76owocxyVwj/JibWjmKPYXbtADdjREdlgF2D/0eLRxBFnJhJZ9P
        mqzLxflf3sOartXZuNH1FWn+PK0BqnT5nulE9LVYWCGTt3sMVP4h/syWjqnoNUg8ytKgW0
        3SfKu6XCS9u5UFu9+r/ONY0Jq7Jonys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-MzAmU9zhPX2Q0xCRCvrp4w-1; Thu, 18 Mar 2021 22:54:45 -0400
X-MC-Unique: MzAmU9zhPX2Q0xCRCvrp4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33C96800D53;
        Fri, 19 Mar 2021 02:54:44 +0000 (UTC)
Received: from treble (ovpn-113-46.rdu2.redhat.com [10.10.113.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9B761002388;
        Fri, 19 Mar 2021 02:54:42 +0000 (UTC)
Date:   Thu, 18 Mar 2021 21:54:40 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] objtool: Allow archs to rewrite retpolines
Message-ID: <20210319025440.ah5kr7aztz4jbzer@treble>
References: <20210318171103.577093939@infradead.org>
 <20210318171920.131630843@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318171920.131630843@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:11:15PM +0100, Peter Zijlstra wrote:
> @@ -1212,6 +1225,8 @@ static int handle_group_alt(struct objto
>  		dest_off = arch_jump_destination(insn);
>  		if (dest_off == special_alt->new_off + special_alt->new_len)
>  			insn->jump_dest = next_insn_same_sec(file, last_orig_insn);
> +		else
> +			insn->jump_dest = find_insn(file, insn->sec, dest_off);
>  
>  		if (!insn->jump_dest) {
>  			WARN_FUNC("can't find alternative jump destination",

So I assume this change is because of the ordering change: now this is
done before add_jump_destinations().

But doesn't that mean the alternative jump modification (changing the
dest to the end of the original insns) will get overwritten later?

Also the new hunk to be an oversimplified version of
add_jump_destinations().  I'm not quite convinced that it will always do
the right thing for this case.

> @@ -1797,11 +1812,15 @@ static int decode_sections(struct objtoo
>  	if (ret)
>  		return ret;
>  
> -	ret = add_jump_destinations(file);
> +	/*
> +	 * Must be before add_{jump,call}_destination; for they can add
> +	 * magic alternatives.
> +	 */
> +	ret = add_special_section_alts(file);

This reordering is unfortunate.  Maybe there's a better way, though I
don't have any ideas, at least until I get to the most controversial
patch.

-- 
Josh

