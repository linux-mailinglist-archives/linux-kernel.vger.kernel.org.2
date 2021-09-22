Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E054148CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhIVM3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbhIVM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:29:49 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C17C061574;
        Wed, 22 Sep 2021 05:28:19 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so3195770ota.6;
        Wed, 22 Sep 2021 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2nkbp5/UFa0WAzqKc+jcXuQDGHNDbtOZlLm7JPrAkR0=;
        b=YFtLnPU56V4/ke+9OMaOBewTo0hUg987s4PvTaBxFL5FsFa4eAZIe9w7wBPk64uf8B
         9pL4S6xnV5WQLp369ii8/aBoN+ZmmVRjdsSyoomDs9w2g1bVgOas8CX78hrSCn7rWNJx
         1acw7TAdMzlWkKvpxIbClqwR8QVU6clrIZKQxcb5YHSq+Z8Qrw+K3vgMzV0GfKAYNEv7
         CgEvKU3u600+Of8KVCFM11oPgm+Slfa0F+Ka/x7l0jATo6f9hPnh7HcEWf+aSUGtWHBD
         nxLsDOVQ3DtnpipL9+kptPIiVSv4S4cHNI3A+0oP8uHchRL9pUCj4DWK+cDHTkDA+wRZ
         7iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2nkbp5/UFa0WAzqKc+jcXuQDGHNDbtOZlLm7JPrAkR0=;
        b=7ibSsbgg6CYczMVu/7tCN5/dl/TYXj0yd6+q3SUPWHMNkGX30UWzXzbb91AlCbouGm
         ae7Nl8LkQBQIzf8TceYeCPirGyZU8flTkqi2lZIkJyw9n+nw6r7x5jN0wv5PKRuRYmvM
         R0wr7cUphWEuDn7FjiNT4Nq0XcuZrjmuMpVJgKFqZl2n/C1zZiDLDuFjU/e/s9Q50l8x
         oBu31JqseNR31GIs6lyAfXu+hKUMRuGt17xZHz5aETePXTrI4SMEt3goDBnNUtEnGULZ
         0kjdxtvH/EeFvFM+7ockp/U+Knra5ecM6BWiH3QoSThBvZLKOb4A5UcMXOKRnmy8Y4At
         xgsw==
X-Gm-Message-State: AOAM5304dXRwU+dFtUhsV0tBuqeQ6EEaDdZKDYrP00tAt0BzJ6CycdxC
        eGlGG6Y+8BaF4XDpE5h3GQA=
X-Google-Smtp-Source: ABdhPJyaLELfrhqDSyfOysDSbvs4nNZCzGIx0aZ5djZAzLKJMd1WFq+GPUkRsXUjDQYqT7l7HgTtDg==
X-Received: by 2002:a05:6830:82b:: with SMTP id t11mr2736762ots.319.1632313698268;
        Wed, 22 Sep 2021 05:28:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4sm458135otj.18.2021.09.22.05.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:28:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 22 Sep 2021 05:28:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: hwmon: ibm,cffps: move to trivial
 devices
Message-ID: <20210922122816.GA3201379@roeck-us.net>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
 <20210921102832.143352-3-krzysztof.kozlowski@canonical.com>
 <20210921123025.GC1043608@roeck-us.net>
 <68fa27ae-4704-181f-e2f6-92635865798b@canonical.com>
 <20210921131804.GC1864238@roeck-us.net>
 <1a8cfa30-769d-d0aa-ffef-1eda42e3a84d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8cfa30-769d-d0aa-ffef-1eda42e3a84d@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:40:32PM +0200, Krzysztof Kozlowski wrote:
> 
> I hope this won't stop from reviewing the few other patches in the set
> adding separate bindings.
> 
I don't actively review dt patches, but rely on Rob to do that.
Reason for that is that I almost always get something wrong.
So let's wait for Rob's feedback.

Thanks,
Guenter
