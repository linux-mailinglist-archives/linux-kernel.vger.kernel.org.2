Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5127D3C372E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 00:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhGJWvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 18:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJWvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 18:51:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE68C0613DD;
        Sat, 10 Jul 2021 15:48:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l7so17210754wrv.7;
        Sat, 10 Jul 2021 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ejPHvShaoGhUxsMGgc5TDqgQVFmW//0KshLDcI6HcRc=;
        b=eyMQ2ZAbkcv2U29UM2IlTwWx+2GJ1etTLOd8siLYaWmLsntrb1423eIqFSYMEeylML
         667zMK+w05MgxbzDBdh+4qy1bxyti7pTp776n+Z47QZZCZBxp/hB+FMTB6TQ8FkI6ihA
         zaN+MKAwkmmq36he1Bya9/SpmR/BfKSQWJDPW51GjJ+VFWV0XxMuO5MjrVpkg4nbGuwS
         5E2sT8qZiuCyxPItgxhAKF0/sGOm9yvSP2w/n1bvTDwf/b+41c8ozdC1xQ/Komxm/vnu
         rrRlPuEQaUuNfYWnkebYL/t87NvqJnDrH5LJEbptjs0HfdbznDGytSBkNzIbsK4uNx07
         P/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ejPHvShaoGhUxsMGgc5TDqgQVFmW//0KshLDcI6HcRc=;
        b=ZQWAA3ZQqVUdacsV4Rl90IAf2G+/Pcc0/1owwkrY8zr9QBGdjunHGg2TIagbNgLSJj
         7+W8KrBaqasSjj4vWJ3QrAp7j087XOEElptY03Qal1mUG/v21VrCksmFrxzYM9ti2cBM
         0dgsZ6RahZBHrQv72eKbBvoc0qqC4poCWsTSairJ8UDO/f5QqeruXjeCE8xjgY6SVsyo
         GxUEvlP57TQGIERXlegHyrnISCUCes+VFQq71quDjYHGhohj8ORpr30ePyIO/ARhcHnP
         Dq7fA1pCvgnf5d0/yjMctxio/WzacRR9YG+EZyZi/BEofKEuYnLoSb3TmfYPf+PgH0IN
         DwbQ==
X-Gm-Message-State: AOAM530rG5RPfMO+q1sVIO9JQ57Tb9zCQOG36UMTb9df6JaWgX/P9VQ1
        qpNIK1IXNEHQDVf4T/kfhh2b1+b6gsU=
X-Google-Smtp-Source: ABdhPJwAsH7SW3PlJP6VQFEf8BPFWPjt3oXuDnt5ZJxHMJOB8Q7NhlXKK7ghtzsr9Fde5BL3Z7upjQ==
X-Received: by 2002:a5d:5048:: with SMTP id h8mr19554797wrt.292.1625957314525;
        Sat, 10 Jul 2021 15:48:34 -0700 (PDT)
Received: from [192.168.1.211] ([2.29.20.111])
        by smtp.gmail.com with ESMTPSA id v15sm16072430wmj.39.2021.07.10.15.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 15:48:34 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hdegoede@redhat.com, mgross@linux.intel.com,
        luzmaximilian@gmail.com, lgirdwood@gmail.com,
        andy.shevchenko@gmail.com, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
References: <20210708224226.457224-1-djrscally@gmail.com>
 <20210709170426.GC4112@sirena.org.uk>
Message-ID: <c95da883-581b-d1f4-4c8a-2162b8b58b64@gmail.com>
Date:   Sat, 10 Jul 2021 23:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709170426.GC4112@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, thanks for the feedback - much appreciated.

On 09/07/2021 18:04, Mark Brown wrote:
> On Thu, Jul 08, 2021 at 11:42:24PM +0100, Daniel Scally wrote:
>
>> See previous series for some background context [1]
> That's a link to a series "[PATCH v5 0/6] Introduce intel_skl_int3472
> module" which doesn't have any explanatory text as to what it's doing in
> the cover letter (just an inter version changelog) nor any obvious
> relevance to this series, are you sure that's the right link?  In
> general it's best if your patch series contains enough explanatory
> information to allow someone to have a reasonable idea what the series
> does without having to follow links like this.


It is, but I certainly could have done a better job of explaining
context there rather than throwing it in (particularly given the
uselessness of the cover letter there, I forgot about that - sorry).
That series contains an i2c driver that binds to the TPS68470 when
enumerated via ACPI. That i2c driver is effectively an MFD driver, it
registers a regmap plus platform devices for the GPIO, clk, regulator
and OpRegion parts of the TPS68470, each of which has their own platform
driver to control them (though only the GPIO and OpRegion ones are
currently upstream - I need to post the clk and regulator ones), all
sharing the same regmap. This series is a follow on from that,
attempting to remedy problems with the ACPI that prevent those resources
from being discoverable by consumers on some devices.

>> This series is a prototype of an emulation of the device tree regulator
>> initialisation and lookup functions, using software nodes. Software nodes
> What is a software node and why would we want to use one here?


Like of_nodes, but defined entirely within kernel code rather than
parsed out of devicetree or from ACPI. I think we need to use them to
make up for the deficiencies in ACPI on these platforms.

>> relating to each regulator are registered as children of the TPS68470's ACPI
>> firmware node. Those regulators have properties describing their constraints
>> (for example "regulator-min-microvolt"). Similarly, software nodes are
>> registered and assigned as secondary to the Camera's firmware node - these
>> software nodes have reference properties named after the supply in the same
>> way as device tree's phandles, for example "avdd-supply", and linking to the
>> software node assigned to the appropriate regulator. We can then use those
>> constraints to specify the appropriate voltages and the references to allow the
>> camera drivers to look up the correct regulator device. 
> So these systems lack an enumerable description of the system provided
> by hardware or firmware (or given that these are ACPI systems I guess
> the firmware description is just broken) so we need to use board files.
> Why are we not just using board files, what does this new abstraction
> solve?


I went with this approach because the ACPI isn't entirely lacking, it
enumerates the TPS68470 as an i2c device for its driver to bind to
without a problem which results in the regulator driver registering the
regulator devices (7 of them for this chip), so I was thinking along the
lines of repairing the problems with ACPI to give those rdevs the right
init_data rather than sidestepping it altogether. I could register the
platform devices for the regulator driver to bind to in a board file
instead if that's the preferred option...usually this would involve
using i2c_board_info I think but as ACPI will enumerate the i2c device
for the chip independently we'd need to handle that somehow to stop them
racing each other I guess.


I'll take a look and see if I can make it work that way.


>> I'm posting this to see if people agree it's a good approach for tackling the 
>> problem; I may be overthinking this and there's a much easier way that I should
> I don't think I understand what the problem you are trying to solve is
> so it's hard to say if this is a good approach to solving it.


Hope this is a bit clearer now?

