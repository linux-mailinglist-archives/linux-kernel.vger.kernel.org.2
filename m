Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3F234D9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhC2WEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhC2WDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:03:52 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9577DC061574;
        Mon, 29 Mar 2021 15:03:52 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c16so14546247oib.3;
        Mon, 29 Mar 2021 15:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/NQhvFj5eS7k//pPWoR9yEacTl1XpNVlMfZ0D3JofVM=;
        b=QqlVjiELedI/JlTJGauw6EXfwiMawlMPbS8SCCjFufAG5N6ATCuCZhVAP5eJ9Xj5c2
         bFlmRccDNAVizfYJAIW8g9Bnk5UT543xHcVFrP2M04h8DzGbJETG3J3EUsSmriCbiAgR
         VvtsvUIkX6Ew3P8qjI4DXtl9WUT+vRkavdni2usM/C+3hZOR+ch2o1iQOnC9y61gK8m3
         gHQWmQpfbTz7ZnCRgTDezbO04ET2jqja9FKLvq4f2b/GbHw6OW2cpJ3OABy4hfRSQK4b
         f3DQ5pA5a6xx4CH18gYMzbTzqA1gp+j+lK5exgetmZSNDc7zLgYG+3z8TNWtetTFX8bX
         iEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/NQhvFj5eS7k//pPWoR9yEacTl1XpNVlMfZ0D3JofVM=;
        b=h8J7jyCkZASfV2tAEisomlBKpkFfV/XBsx3BN72vCHwyXacqygcP91T+iyGvgXjPSF
         JHDGhqDhNpcpKjR6gn86kVUdjbR459JOyuQF+Dj0cfX/ypPs7uZpyRHioYi7OWvvXixn
         7xq1xp1vk0AJvKxDA6SOoMy7ivmpSD3M9RBxibcTVrMoXhaXBOa1n8Wkn3vbFFkZ/VJI
         Z6mnKGx0QAW+l4I19Z6d5IyTaR7cXyqx3MgCK+V5xY4l2B6tLa/4xY4dtx2CGuzy1oQO
         nPtptrhOs0N0Hh2ZtpLTL4uL04ur8Mwh4+JfDiTqpjj4Rv+XNtyChI3ZlV9FT92RecHK
         4PRA==
X-Gm-Message-State: AOAM533AyMAZ6B4tDx5Z2/CPhiz0YWSPIH5Qmfosj5YQooDjofJ0NDon
        qg0w40xthGkDa/1Axsce1wE=
X-Google-Smtp-Source: ABdhPJxDZFz/ffS3eDiAKgeAHm6ea7e12k7seYloXSp6jphZcdwRUaMeqdVTgD8b27j1sq5mo3HShg==
X-Received: by 2002:aca:f13:: with SMTP id 19mr875897oip.56.1617055432063;
        Mon, 29 Mar 2021 15:03:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o10sm4727761ote.5.2021.03.29.15.03.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Mar 2021 15:03:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Mar 2021 15:03:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, jdelvare@suse.com, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: Add vendor prefix and trivial device
 for BluTek BPA-RS600
Message-ID: <20210329220350.GA221755@roeck-us.net>
References: <20210317040231.21490-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317040231.21490-1-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:02:29PM +1300, Chris Packham wrote:
> Add vendor prefix "blutek" for BluTek Power.
> Add trivial device entry for BPA-RS600.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter
