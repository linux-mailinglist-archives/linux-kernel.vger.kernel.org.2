Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7023158FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 22:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhBIVw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 16:52:57 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37687 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhBITY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:24:58 -0500
Received: by mail-oi1-f181.google.com with SMTP id y199so18607545oia.4;
        Tue, 09 Feb 2021 11:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=djpia0FYNCw9tE3WP5Tr7Z3WXN4BAb7/Bz2WXM06cjM=;
        b=BZILmMhDOGBhIZVZfWPtmTZXmwq6vLPMFLDgpUy2ZutM/zMiIpA8i+vv5xFAfHnkB8
         gbT32RqyzZ/VkkQScnOxb/oQgeXViRf1koOMqqJHKeQf8ROVg1alVzA7YUPQze6Vewf7
         dBdq3pATD4/IliNprUp9SKOCr9a87m4kq9iS4unzXM3vouo+HLp0zmCpQR4AJPWaLS1U
         49Sy3pDVI6CTEQ5OysKJVOWUyWV+1f6m6cJhAw7MemvpdyJnUVSKVcMtATPz6+TRQ20M
         LuwFN2gMOP2TioCpLEhjnRbnGb2dt+hTijdOqOFJEQMPTUuMbwU3sPBSeNzslRESspP+
         yJPQ==
X-Gm-Message-State: AOAM531pC1bLQm2SFPY7JHl5bnc5ADc0jcGWSp1Tu/gFBTaKwbAw1oSG
        kT5lKWmGkW5P+2YR3QwhpGS3XZUFeQ==
X-Google-Smtp-Source: ABdhPJxXHj8LriG5h7lJxb2HcSAF8ts/EcRL9+I3AD9cV1JfGEQuW4cd3YqKhp5vJufOIMZhs5T04Q==
X-Received: by 2002:aca:2102:: with SMTP id 2mr3615711oiz.80.1612898444606;
        Tue, 09 Feb 2021 11:20:44 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i13sm2821404oth.52.2021.02.09.11.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:20:43 -0800 (PST)
Received: (nullmailer pid 4189533 invoked by uid 1000);
        Tue, 09 Feb 2021 19:20:41 -0000
Date:   Tue, 9 Feb 2021 13:20:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] dt-bindings: power: sysc-remobile: Convert to
 json-schema
Message-ID: <20210209192041.GA4168680@robh.at.kernel.org>
References: <20210127132840.2019595-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127132840.2019595-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:28:40PM +0100, Geert Uytterhoeven wrote:
> Convert the Renesas R-Mobile System Controller (SYSC) Device Tree
> binding documentation to json-schema.
> 
> Document missing properties.
> Drop consumer example, as it does not belong here.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Marked RFC, as it does not check deeper levels than the first level of
> the "pm-domains" subnode.
> 
> I think the reference in
> 
>     additionalProperties:
> 	$ref: "#/patternProperties"
> 
> should become "#/patternProperties/0/additionalProperties", but that
> gives:
> 
>     Unresolvable JSON pointer: 'patternProperties/0/additionalProperties'

AFAIK, numbers only work on lists (such as 'allOf' values). So I think 
you'd want '#/patternProperties/^pm-domains$/additionalProperties'. 
However, regex's can have illegal characters. I think URI escaping them 
would work, but that gets too readable and unmaintainable for my tastes. 
The other way to do this is put the schema under a '$defs'. But in your 
case, you have just a fixed string, so there's no need for it to be a 
pattern. Just move it to 'properties'.

Otherwise, looks good to me.

Rob
