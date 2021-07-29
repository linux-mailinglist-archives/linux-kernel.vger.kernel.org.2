Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDE03D99E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 02:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhG2AHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 20:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbhG2AHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 20:07:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF43DC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 17:07:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i10so4778904pla.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=652c8+1KBJbyC2zYVRbRKgp8eVRPzm13FBaiNxdDRtY=;
        b=o3XDZtCrp/n4ID0XJ1QoYno+6w+0gssu3DR3nRuyzSgVz5L62KRTllVdtXUhI8QBF6
         95XEIzHtunOTEgkzV4wR4GTvhTjit+hNHXK+PiY1gZvLJHBLgNn1IilBrrMrqDwh7xQR
         aefUUWXuEVx1kCX2MYdDzCfe17E8uQ4X/8Q41PinoZPlrw0IIbrLsessAHBmS4crXcRm
         +PpKgNKwSpdt/XULmtvG1caQUqjjQM0796hejXlI1kU1pb0vWKLazvblmjSwLzDq95HP
         6VKNyuO2pJI2qOz8d6g9bpB+Q5vHIWv+ISQhWcNRP5kztWRBmT/LaVqKxnjBVAJXm9V6
         tZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=652c8+1KBJbyC2zYVRbRKgp8eVRPzm13FBaiNxdDRtY=;
        b=Zzbb6j4cbnSuT7g8PzmXuKcL7ITwktiE0kaHDRatGuBKDvpyfofzSwHiOKbk055LJ4
         swipAVH218MA68RrrZ7421nfdLapaabUDYubNM/cu5yEbDdM+LR19ClRtcEP2JPJ3qeG
         /mjj7MowISjysp3jWmFIdkM+EImnkgCwj369sh/KQqB/kjX9CSY4EYeKdnnuLkCEKiYX
         eseoTC89SxgT7UmgFABD4XTMC4o4s1cu5n2jyX7L+s0uZMPql5hRf9xpQEWxPmFU3fKy
         mrMiQFp2yC5WC9BDGHICkYdAJFInFSSqDv2BEId2YMIoTHYAVx64cVab2hYaYUhzWYVw
         u3Ew==
X-Gm-Message-State: AOAM530e49/JrKSnhS7bijBPksuEYSfSUiuFo7Fi1HZS/yWjul7FBHgj
        WMNM6RwBD2fjZW368+TgtFEj6Q==
X-Google-Smtp-Source: ABdhPJxspD9NvdRTISMdUWpQGX3Y+ISwQXb8lwqzAG8G+qFXb9ce8eMJ7t4cZ/2+V7lPB4YAH0jqVg==
X-Received: by 2002:a63:4446:: with SMTP id t6mr1385476pgk.76.1627517232177;
        Wed, 28 Jul 2021 17:07:12 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m18sm1228000pfd.42.2021.07.28.17.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 17:07:11 -0700 (PDT)
Date:   Thu, 29 Jul 2021 00:07:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] x86/sgx: Provide indication of life-cycle of EPC
 pages
Message-ID: <YQHxLG5fSTWPgez6@google.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-2-tony.luck@intel.com>
 <17054ca5-0ef7-4b28-ab26-b1b96aa7403f@intel.com>
 <f2685d7c8dc14792a4e0f9807f742ea6@intel.com>
 <fd8f8e79-f63f-7d6f-277e-1ad08ab7b6b8@intel.com>
 <YQHpGq0GyAsYpE+D@google.com>
 <b05acb65cebc4718a5cc2503ced7455d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b05acb65cebc4718a5cc2503ced7455d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021, Luck, Tony wrote:
> > -       epc_page = sgx_alloc_epc_page(NULL, true);
> > +       epc_page = sgx_alloc_epc_page(va_page, true);
> 
> Providing a real value for the owner seems much better than all the hacks
> to invent a value to use instead of NULL.
> 
> Can you add a "Signed-off-by"? Then I'll replace my part 0001 with your version.

Signed-off-by: Sean Christopherson <seanjc@google.com>

> -Tony
> 
> [Just need to coax you into re-writing all the other parts for me now :-) ]

LOL, it might be easier to convince folks to just kill off SGX ;-)
