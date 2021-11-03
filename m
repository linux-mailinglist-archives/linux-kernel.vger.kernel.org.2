Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED76443D53
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 07:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhKCGkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 02:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhKCGkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 02:40:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A6DC061203
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 23:37:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id iq11so603504pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 23:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KvV07TGoZaoGw8L0LWYKUbxKaPDqvzThxG6WFrFLoZE=;
        b=qV6o2DHzNyXcnTFQQPyEAH5HGAgqErf+nLausmvme7o+/HaH5BSY6GgQgYvm3NkDV1
         OR0M6iMn7ErGmFwBNJwqGcnzu3l2AYFln/0aOue4QU9nVvw9ay2ysnUE2cF7dZWoUOYH
         zLARG2g2WK8ganoyxRfEwndQ4J/4Irml4yeScRNO3KiamTkfwqbjH+IAAIoL15ZP5V26
         1v5s1K+xO1a1+PH3LDRkuvG2tCjW+/AJpoOYNzC9a4nhJRD9Sr7QgBzIa9O7SeyT2KwP
         3Ddois9E1aWdVaOecGfUI/sREvr3AoThqfVKlOv1mH9c7izxYcqWyPDhvnLUSt8A5x8+
         O9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KvV07TGoZaoGw8L0LWYKUbxKaPDqvzThxG6WFrFLoZE=;
        b=EWHLPqXDemqxrncPuwwFL75gsxEtr8GDB9VycM1CD19Ey1760wz4EioZk5MLUWL7ac
         7XQRv73RjZ8FUdjiTZ7eCRdYjpn236D7/7+ynxFw7lY+iqYeYAcpZSU0DzRBgW22hFeD
         zh4w/EOej65y8STLjozXd2lHsr1nhPbpGABZ+EAOBMUIs80OpDuGYWewujFPkNeuOm6y
         ju7kN8o5WNMDO0S3dqo00SajUtLXDkPvRcskJmwiZUhBxdP7+UUz1ikBQycvomiILssG
         a+a2i48/EzbymjZRr6UyDFCwyTrQylrLS0+TmRRcRNCriGb72dZpKUAxwMs/AlCZCw2R
         JcJA==
X-Gm-Message-State: AOAM533Y0+5HToaFR6N8Gspehtmlz6Pm5BA5QgO5wlXVJrh50RhcacVj
        1uBCNslMdtUMIyUxjzbk+ubMV6l7+iYhBA==
X-Google-Smtp-Source: ABdhPJzCmOo15jlPdgZPi4SyQjZk/5+4lEfnC9j8LuN0Fw6C+DU4a7f23C24EyvWV1cMUmhMJaL6/A==
X-Received: by 2002:a17:90a:928a:: with SMTP id n10mr12308079pjo.128.1635921467640;
        Tue, 02 Nov 2021 23:37:47 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id oa4sm930068pjb.13.2021.11.02.23.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 23:37:47 -0700 (PDT)
Date:   Wed, 3 Nov 2021 12:07:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Chen, Conghui" <conghui.chen@intel.com>
Cc:     "Deng, Jie" <jie.deng@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211103063745.utpphthou4angs4s@vireshk-i7>
References: <YW+q1yQ8MuhHINAs@kroah.com>
 <8e182ea8-5016-fa78-3d77-eefba7d58612@intel.com>
 <20211020064128.y2bjsbdmpojn7pjo@vireshk-i7>
 <01d9c992-28cc-6644-1e82-929fc46f91b4@intel.com>
 <20211020105554.GB9985@axis.com>
 <20211020110316.4x7tnxonswjuuoiw@vireshk-i7>
 <df7e6127-05fb-6aad-3896-fc810f213a54@intel.com>
 <20211029122450.GB24060@axis.com>
 <8592a48d-0131-86bf-586a-d33e7989e523@intel.com>
 <MWHPR11MB0030C3489F38FF2AAF7C3D0A908C9@MWHPR11MB0030.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB0030C3489F38FF2AAF7C3D0A908C9@MWHPR11MB0030.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-11-21, 06:18, Chen, Conghui wrote:
> >>> Over the long term, I think the backend should provide that timeout
> >>> value and guarantee that its processing time should not exceed that
> >>> value.
> >> If you mean that the spec should be changed to allow the virtio driver
> >> to be able to program a certain timeout for I2C transactions in the
> >> virtio device, yes, that does sound reasonable.
> >
> >
> >Due to changes in my work, I will pass my virtio-i2c maintenance to Conghui.
> >
> >She may work on this in the future.
> >
> 
> I'll try to update the spec first.

I don't think the spec should be changed for timeout. Timeout-interval
here isn't the property of just the host firmware/kernel, but the
entire setup plays a role here.

Host have its own timeframe to take care of things (I think HZ should
really be enough for that, since kernel can manage it for busses
normally with just that). Then comes the virtualization, context
switches, guest OS, backend, etc, which add to this delay. All this is
not part of the virtio protocol and so shouldn't be made part of it.

-- 
viresh
