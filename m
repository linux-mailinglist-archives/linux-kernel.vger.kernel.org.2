Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511C8349DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCZAVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:21:12 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:45733 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhCZAUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:20:49 -0400
Received: by mail-il1-f169.google.com with SMTP id w2so3208902ilj.12;
        Thu, 25 Mar 2021 17:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AENgAWH1NANoYRe4oyIttR/P/MAGP1UF/GSmZ4hpSLk=;
        b=YwopgSk7dbWFAth7JgemiOpycUXlqkfkCVNiTQolZM+SUgWcOqAIkbjuq3ongVAFG8
         /NO9pSrzldthDgDl88hBH9MFzLDXuG2aj2N3y9J/JePWdXYqIlthbCNhd/CSKS3P8UIk
         lbk5NJQIpP1N9OO6DnBTEJvmYOZdtR6+VBteSr7ppVkOej0MiSDejOPyK2EiRtfYS9NL
         +7yGAc2hBhCIAEeqMaSwHGD8owzqXSyajuEqTw06ksKiLc2JMUI55ABrDfji+aAd/H3Q
         6fj9SmFJ9PqDtOTZiu8t0oeepb4xt58jIUGwvjtjsBBkVCufWmai/5GSkdIXXNztB1af
         nvrw==
X-Gm-Message-State: AOAM532m9j37vv0yt9ZoXAbDiWOO/Cl7nc0vtC3yorq22AX0IN7TJHEU
        BUHtJlsWWaBxySANFGVLWw==
X-Google-Smtp-Source: ABdhPJw77lvnxPuHdiO6Ji9kmIO5+JODXwQ35Yi75d5AwOqA3dNFEpvLhLz0ifmyBG4LRuQMSVmxUw==
X-Received: by 2002:a92:5411:: with SMTP id i17mr8497509ilb.22.1616718048673;
        Thu, 25 Mar 2021 17:20:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y15sm3283345ilv.70.2021.03.25.17.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 17:20:47 -0700 (PDT)
Received: (nullmailer pid 2020031 invoked by uid 1000);
        Fri, 26 Mar 2021 00:20:46 -0000
Date:   Thu, 25 Mar 2021 18:20:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devicetree: bindings: clock: Minor typo fix in the file
 armada3700-tbg-clock.txt
Message-ID: <20210326002046.GA2016315@robh.at.kernel.org>
References: <20210317100840.2449462-1-unixbhaskar@gmail.com>
 <546989ea-c6b2-42e4-46b2-d7de5d208728@infradead.org>
 <YFJcl6i95cRM22MI@ArchLinux>
 <efc138db-d82d-a9f0-ca7b-61ae993e0459@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efc138db-d82d-a9f0-ca7b-61ae993e0459@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 01:12:28PM -0700, Randy Dunlap wrote:
> On 3/17/21 12:46 PM, Bhaskar Chowdhury wrote:
> > On 10:32 Wed 17 Mar 2021, Randy Dunlap wrote:
> >> On 3/17/21 3:08 AM, Bhaskar Chowdhury wrote:
> >>>
> >>> s/provde/provide/
> >>>
> >>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> >>
> >> Bhaskar,
> >>
> >> Did you send this one to "robh+dt@kernel.org"?
> >> AFAICT, it was sent to "dt@kernel.org", which bounces.
> >>
> >> If you used "robh+dt@kernel.org", it appears that 'get send-email' has a problem with that.
> >>
> > I sent out a mail to David and Rob, including you for the same problem . Hope
> > David will do something to change that address or Rob might do something . So
> > that it will not bounce in future.
> 
> David said that vger isn't modifying the email address.
> And there is nothing wrong with it (robh+dt@kernel.org),
> although it appears that either git send-email or just gmail.com
> does not like it.

I've used that for years and never heard of any problems.

Rob
