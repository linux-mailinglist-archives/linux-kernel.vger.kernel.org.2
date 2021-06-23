Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9B93B1EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhFWQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhFWQij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624466181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mcpQ5NPR2YFFd7daoqcO78pFvQVEgMzcMJsDe0rwIw=;
        b=haol5V9Y/K7cPT1Z3tJbHLKZ9rr4LInWSmoP3ufZvADHD4hPwHn49NMVvdWG7V0Dvve9qX
        GlE2dOoG6qNrMX0iPduUbYCJJMaf8KzHA8ZuMxX53ax0HfiOmFQNjBW5YSC4AvIp49w5gv
        yxRtWQ0WFAsO7SOvTVX58rJVn+t0K5U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-6xJof8IIODyMIdlkhJ2VFA-1; Wed, 23 Jun 2021 12:36:15 -0400
X-MC-Unique: 6xJof8IIODyMIdlkhJ2VFA-1
Received: by mail-wm1-f70.google.com with SMTP id j6-20020a05600c1906b029019e9c982271so1837085wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+mcpQ5NPR2YFFd7daoqcO78pFvQVEgMzcMJsDe0rwIw=;
        b=Uu0Ljr9fcXmiyZILUdPQjYJLJwzPCgQVFS98ASvI1rGZeR+Gui/P9aQR7AyEr+eRmg
         rO0fW0cMm+MNZnAKw42ktFvpnmmqPLEUN53qvqcPql9lkj+ixUDbVT9nwLArVZFZUGtk
         +YbmlT5QoV7FHQS+RDTfnBUNcn3qH1QRxluRb756UyvwgfdEppMi+BS2qQQzY9Foa7t+
         HVaYNGtPAmbbb9/MsMa9NIchkjfbcuhTwT4r47Q4jpfH+7vR748tFYmjhrrVWzQDrWcu
         K2H606Pu04deBRMJO9sGuAsKWT8HWYXmeKHD1FdHaa40vXFkXNqq5NOPoG02CvNbQjWi
         MFhA==
X-Gm-Message-State: AOAM531Ukv7PJMLY/tk+ZhvrtS+ODsFMlnnKv6g/rPr6x3xQeNu2wksV
        rCTfEDCb1hRz1igBlDBiTD/c8J6SrG9EpwfF5peD1s7fRisnqYrhr1+EGNqNly/c27LNqbEe3p9
        bfiyl3W1w3QjQS/lP4VI/++Mz
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr1117843wrw.104.1624466173866;
        Wed, 23 Jun 2021 09:36:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8ahcTNyebFbGA28jWi8hR8gKO5JD6pROf40mnz5Gh2lW6cOQ7BUZJZiRnyROGJP2NMQkqhA==
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr1117828wrw.104.1624466173729;
        Wed, 23 Jun 2021 09:36:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id d3sm524054wrx.28.2021.06.23.09.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 09:36:13 -0700 (PDT)
Message-ID: <254a0b83518083416abdae4cd27659bc10760773.camel@redhat.com>
Subject: Re: [PATCH 5.10 038/146] mptcp: do not warn on bad input from the
 network
From:   Paolo Abeni <pabeni@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Date:   Wed, 23 Jun 2021 18:36:12 +0200
In-Reply-To: <20210623142235.GA27348@amd>
References: <20210621154911.244649123@linuxfoundation.org>
         <20210621154912.589676201@linuxfoundation.org> <20210623142235.GA27348@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 2021-06-23 at 16:22 +0200, Pavel Machek wrote:
> Hi!
> 
> > From: Paolo Abeni <pabeni@redhat.com>
> > 
> > [ Upstream commit 61e710227e97172355d5f150d5c78c64175d9fb2 ]
> > 
> > warn_bad_map() produces a kernel WARN on bad input coming
> > from the network. Use pr_debug() to avoid spamming the system
> > log.
> 
> So... we switched from WARN _ONCE_ to pr_debug, as many times as we
> detect the problem.
> 
> Should this be pr_debug_once?

Thank you for double checking this!

In the MPTCP code, we use pr_debug() statements as a debug tool, e.g.
when enabled, it could print per-packet info with no restriction. 

There are (a few) similar use in the plain TCP code.

pr_debug() is not supposed to be enabled on any production system,
while the WARN_ONCE could trigger automated tools for irrelevant
network noise.

I thing pr_debug() is fine here.

Cheers,

Paolo

