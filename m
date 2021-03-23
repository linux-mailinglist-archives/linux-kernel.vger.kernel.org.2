Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FA0346D87
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhCWWre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:47:34 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:38901 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhCWWrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:47:10 -0400
Received: by mail-il1-f169.google.com with SMTP id d10so12901125ils.5;
        Tue, 23 Mar 2021 15:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6AvTzTJOE2gdHJ0jAl+cPe+wrFwOXJMa+4lkL1LoiVc=;
        b=cpRrZm+zhsKGY5ioGJfmShm1vfWM65BUcTPV6iljCDH3pslNXIMObzFxCC9nXAL1ZO
         aFv3rjCLe3FfJpsP21fuxsO5YBe0F+nY6sno+xZ8okG0OcoNjwHF4OuArXWh7SFKbDMU
         x5Ds63V7EL6znNkepuB0CrQCqcUUazIlj/Wem7iZfwHKqM2DJFm68p0miwW1rljYUH9R
         nQa8e2cSnetSMz9AlTVd+bNwdHyv5ltlt8Riwnr9RwvNdPKkjEMaVrIfaG4w5+igZmk3
         vL8uNMdNT4hbSwJJflRJC8BFXqfMUpx33AXBNim0e9utiw/TtQj7cyi583qg6ZGPYAKb
         n6Pw==
X-Gm-Message-State: AOAM531O8OvaRKDBZ4oKZqxpc2QzI80caQRepa6oSj1gVeUKFHh+cWvz
        erOzgsYI6cCcoLjoLiJJioyk0KUiPg==
X-Google-Smtp-Source: ABdhPJxKDO7Wh/viLDxew90U7hRX/c7nWyGGJAhip302aaAmxwMw11ciA4E5DtW5YvV9Mu7WUEYoxA==
X-Received: by 2002:a92:dc83:: with SMTP id c3mr378452iln.167.1616539629624;
        Tue, 23 Mar 2021 15:47:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e2sm120890iov.26.2021.03.23.15.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:47:08 -0700 (PDT)
Received: (nullmailer pid 1490458 invoked by uid 1000);
        Tue, 23 Mar 2021 22:47:07 -0000
Date:   Tue, 23 Mar 2021 16:47:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        yung-chuan.liao@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/9] dt-bindings: soundwire: qcom: clarify data port
 bus parameters
Message-ID: <20210323224707.GA1490400@robh.at.kernel.org>
References: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
 <20210312120009.22386-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312120009.22386-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 12:00:01 +0000, Srinivas Kandagatla wrote:
> Some of the parameters for data ports are not applicable or not implemented
> in IP. So mark them as invalid/not applicable in DT so that controller is
> aware of this.
> 
> Add comment to these bindings to provide more clarity on the values!
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/soundwire/qcom,sdw.txt           | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
