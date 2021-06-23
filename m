Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11373B1F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFWRVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 13:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229831AbhFWRVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 13:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624468773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eafgGiX6GDLeKBcSkHNVWv30fndO9YqdjKRuqwRhCEI=;
        b=YUBPRDmiHXnKrQMawNpBLM+UWHZv466SNn1NCTolgmPbsiijCTl+n2fZWPK3njLwo+uylG
        Tm7pB036tZgI7BLReP1nTrjMp5wEDg9TRTLxWQ1HX7Dgbvz2VVAbvu2rSRdUTfTQzPdLvN
        wpe4Kq9KVWJDcmbi5nOxMISrTYH19Ac=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-u4aFoMtNNOeM_oekqbXIhg-1; Wed, 23 Jun 2021 13:19:31 -0400
X-MC-Unique: u4aFoMtNNOeM_oekqbXIhg-1
Received: by mail-wm1-f70.google.com with SMTP id i82-20020a1c22550000b02901d64e84b3c9so850237wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 10:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eafgGiX6GDLeKBcSkHNVWv30fndO9YqdjKRuqwRhCEI=;
        b=EjfYx1xrn8BYtp7aHttI6Ao3AlUaL5HXxhd9zstFyozqm2KY93Zr9apaTcYkfQu0pB
         yxA9GYIP9mmmEfOnON38y+kZLP7XULM1u2O2vtB74neaf5wZ4c0KmowrXGUeWDW96ARz
         utF8vvpFc1RQXHd5m0rW7H7mUYdu3bxqD2meikt8m3YlnR+pIPwAuoFeSH2BEBLnUZYK
         /m49DBaUOYZBlwi0rl5EkFBYo8z/Y9AA7LJu40AfZf+K5TiCavJUsL7JwEBUJW4cqKvt
         mn1ZezvK2jZCH5Ba3PCbXSsKHRMho2kd6VTVlrYvBG4m+Mheym3hoQJ71jn4n3uRSO49
         eMTg==
X-Gm-Message-State: AOAM533zZUZhJ19CleCHOUETFXnhvAegpf7wlK6xCHCp0ffKHuef3zKZ
        rynLkRC4j962VXlUByM0883bdQVCZteTiZrynLvfdmVA+gJSEOZsfTGH59N8QYTdMhUvttPxTRd
        mDRpjhXQu43OfISHaVhw5mhf5
X-Received: by 2002:a1c:98c9:: with SMTP id a192mr12303317wme.66.1624468769815;
        Wed, 23 Jun 2021 10:19:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykWKB2L8Jmzzeev9nZF/sDxjnXuBMTRrk1niG8jzrlOvAOHlT9AYg06Klj23R2wVc210QqJQ==
X-Received: by 2002:a1c:98c9:: with SMTP id a192mr12303283wme.66.1624468769546;
        Wed, 23 Jun 2021 10:19:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id z4sm633801wrs.56.2021.06.23.10.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:19:29 -0700 (PDT)
Message-ID: <97fd842e75ef1dd7d78b99441d5654fb9a05e320.camel@redhat.com>
Subject: Re: [PATCH 5.10 038/146] mptcp: do not warn on bad input from the
 network
From:   Paolo Abeni <pabeni@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Date:   Wed, 23 Jun 2021 19:19:28 +0200
In-Reply-To: <20210623165327.GA4150@amd>
References: <20210621154911.244649123@linuxfoundation.org>
         <20210621154912.589676201@linuxfoundation.org> <20210623142235.GA27348@amd>
         <254a0b83518083416abdae4cd27659bc10760773.camel@redhat.com>
         <20210623165327.GA4150@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-23 at 18:53 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > From: Paolo Abeni <pabeni@redhat.com>
> > > > 
> > > > [ Upstream commit 61e710227e97172355d5f150d5c78c64175d9fb2 ]
> > > > 
> > > > warn_bad_map() produces a kernel WARN on bad input coming
> > > > from the network. Use pr_debug() to avoid spamming the system
> > > > log.
> > > 
> > > So... we switched from WARN _ONCE_ to pr_debug, as many times as we
> > > detect the problem.
> > > 
> > > Should this be pr_debug_once?
> > 
> > Thank you for double checking this!
> > 
> > In the MPTCP code, we use pr_debug() statements as a debug tool, e.g.
> > when enabled, it could print per-packet info with no restriction. 
> > 
> > There are (a few) similar use in the plain TCP code.
> > 
> > pr_debug() is not supposed to be enabled on any production system,
> > while the WARN_ONCE could trigger automated tools for irrelevant
> > network noise.
> 
> Correct me if I'm wrong, but I believe pr_debug will result in
> messages being stored in the dmesg buffer, even on production
> systems.

If DYNAMIC_DEBUG is enabled, and the system administator explicitly
enables the relevant debug message writing suitable data in
/sys/kernel/debug/dynamic_debug/control, yes, the message will be
printed on dmsg.

With DYNAMIC_DEBUG disabled, patching the kernel and defining the DEBUG
macro in the net/mptcp/protocol.c file you will get again the debug
message.

Neither of the above fit productions systems IMHO, and I'm not aware of
other options to trigger the relevant debug message.

I personally have CONFIG_DYNAMIC_DEBUG=y in my kconfig and I enable the
relevant debug message as needed in my devel activity.

Cheers,

Paolo

