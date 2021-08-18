Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C843F0B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhHRTJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233715AbhHRTJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629313705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tp216Z1B4x9IQEM6aUrfFJCsyNTBB/9H6ygLcXZZWwk=;
        b=PUZzAeCgaZ6nkwJ60FzXBlStPTAYO2Pr9ay/A8ip1U7UDTi3Twmwy7HbUdeMwelvwQ97PN
        ctUlMytEienLE3Z1HrYe0rxPKpG2lU+8+rQgitkxaXlpEakNdCTTNr1GB+AqMOpue64pGN
        FAYLWRyIXK3E7Eq4miEwnsSLIgbUbVE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370--iUEuD0IMnu3GWmRPbVLgA-1; Wed, 18 Aug 2021 15:08:24 -0400
X-MC-Unique: -iUEuD0IMnu3GWmRPbVLgA-1
Received: by mail-ed1-f71.google.com with SMTP id b25-20020a05640202d9b02903be7281a80cso1553626edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tp216Z1B4x9IQEM6aUrfFJCsyNTBB/9H6ygLcXZZWwk=;
        b=NxUtPX1pQQdDhqaSw5lyo7cX5qaIeCJYKFSpFO/nhx0r/X9Hfb6nXFQrcdaNR+7HID
         lcQLIDZnsV6IEWTvclIkAzKyuPZXdkRDOYg7SbW+69/gyA/Hw9NFWAJaBOHgD7k7/bMy
         o9qnx5pAkgC02411Xc5/sIuQOzt8PCeVdCWAOJ5uA3bk6mjNZ/xURAO/B7cCFmkUpPje
         cnidQCw9o2uExPbOPf7XgyCjBkEgVAirCiqAk7FNDdxoBi2LsjpVVSeT/YsnnIUWuVhr
         Tryn8zeyZIeIS1AkudBIGELXrYbQQYKWDkhnr62I9z+e1kJSJJLkek3xBuOjCM2putlh
         1Tnw==
X-Gm-Message-State: AOAM530OLZsyvirPTZfbkp1nN4tjN85gGPTNm2jgPgy8qTiDVLy+F+Zy
        Ug20SalquJ0cQee+yTreW18QcO8oIGHJpuRJjGOmEnxdWaDpi1ChOF9ZEwdjIXkakeFjYmvyCIi
        VaezupMFKaKPFtEJlsOdScn2c
X-Received: by 2002:a17:907:265b:: with SMTP id ar27mr11542562ejc.300.1629313702885;
        Wed, 18 Aug 2021 12:08:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1Pn1PI04Ekx2RrFjzRalquNFFmkOsafXBNm2k44DoJGPJZYiaYMhaIvJ1EocB56ZAMkilmg==
X-Received: by 2002:a17:907:265b:: with SMTP id ar27mr11542546ejc.300.1629313702745;
        Wed, 18 Aug 2021 12:08:22 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id k21sm261695ejj.55.2021.08.18.12.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 12:08:22 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 1/1] ishtp: Add support for Intel ishtp eclite
 driver
To:     "K Naduvalath, Sumesh" <sumesh.k.naduvalath@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>
Cc:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chinnu, Ganapathi" <ganapathi.chinnu@intel.com>,
        "Kumar, Nachiketa" <nachiketa.kumar@intel.com>
References: <20210730155801.15513-1-sumesh.k.naduvalath@intel.com>
 <e27afe05-77b0-f9e5-fb8a-c4a820b3ea60@redhat.com>
 <BYAPR11MB37528C0BE125D5E877A4C9A8A9FF9@BYAPR11MB3752.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c68f2888-a4ee-f3f5-8907-e0916985e2f4@redhat.com>
Date:   Wed, 18 Aug 2021 21:08:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB37528C0BE125D5E877A4C9A8A9FF9@BYAPR11MB3752.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/18/21 8:25 PM, K Naduvalath, Sumesh wrote:
> Thank you Hans for your review comments, and my apologies for the delayed response.
> Please find my reply inline -

<snip>

> I'll put through some tests and submit V3 if you don't have any other comments.

I've no further comments, splease send v3 when it is ready.

Regards,

Hans

