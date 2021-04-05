Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996E235422A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 14:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhDEMpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 08:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhDEMpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 08:45:22 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0DC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 05:45:16 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q26so11263075qkm.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CSK6JwIlplvuME6JSOAFf9YvW54cs29NnCjP+aPjJw4=;
        b=BBV1gkJ/iPNEgfKVx+hEu3c+ADmjKrNPQzmNl8H3QpizkOi3OJZiYworMW7um8UXRw
         xsBeWvPt7q8lSbz2Uk29dJuzfCy+k2dVU3GPGyhQ2z9/eIcjaQapVRPy7nC1y9JunjUV
         ppq/3G2Wt2kg69LHMQdNkrJT8mukFT0ADW7rKiPYD8o0VtdrN76GYusOqrTEIbpiRwkg
         v8T8xavfwws2+d+K0nFxUg/wx3SmGE33lHQOfs42f7/RDxY5rAs9s2uTCQrmIqA7WSni
         Qb5YKwC83XTWy8yE1TiDaz6L0poESZ4GsRLjzkAE2whE7cIGgA1HljjD+2nQ0JJYEKsL
         bJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CSK6JwIlplvuME6JSOAFf9YvW54cs29NnCjP+aPjJw4=;
        b=jZF/AaQNfMrhi+QtUY5L8LLEAWQOg1ogfTHqaaXA6WcWtk3AHhnm7WFRcFEMuD8fXj
         DSa3TGF7bEmLq5UPCsDyPsrvT8DBgKjdKxsgilRybcAYHMFDdT/GrQTpXCmkp2uC18E2
         kwt/KRIsYd2jyjlZ+cbFf8pIwfAc8djlbV63PjN+COWmQ4YV1zUFR6Z0mknRFo7BdHML
         iTj0aY0C2/qVpmTKxopNsyjzlKRTaZG7RB7y0NiT8fc/6wEgwrzRevR7852rB8M22Fq9
         uTEh9N3IuFzihtojuz/StA9pv8dWwh/9FC7ty2Mgmo2ee37hkoi6052l1OubaHbKhGls
         N0zw==
X-Gm-Message-State: AOAM533J5tlV4jvtsyS7JjOc5Qb+2oZ2ruGBCGr7s+3pndutQHiY893t
        Ikl2fY8aIQ/SgEJWpSf2TbQ=
X-Google-Smtp-Source: ABdhPJxUcwoBnqW79l6k72j2/OIWF6rgAmLIG71mESRI2dmtqShq6Ol8TIsndOS8AEQNRKdLFsZAQw==
X-Received: by 2002:ae9:eb58:: with SMTP id b85mr24155260qkg.168.1617626715459;
        Mon, 05 Apr 2021 05:45:15 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8167:5000:d94c:b1e1:5a07:101c])
        by smtp.gmail.com with ESMTPSA id z24sm13169842qkz.65.2021.04.05.05.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 05:45:15 -0700 (PDT)
Date:   Mon, 5 Apr 2021 09:45:57 -0300
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zbr@ioremap.net, corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] w1: ds2438: adding support for calibration of
 current measurements
Message-ID: <20210405124557.pxkkpv3zxvkkengl@LuizSampaio-PC.localdomain>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
 <YGrsMmsI+Pvadow3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGrsMmsI+Pvadow3@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 12:53:38PM +0200, Greg KH wrote:
> On Mon, Apr 05, 2021 at 07:50:00AM -0300, Luiz Sampaio wrote:
> > The following patches aim to make a user able to calibrate the current measurement of the DS2438. This chip uses a offset register in page1, which is added to the current register to give the user the current measurement. If this value is wrong, the user will get an offset current value, even if the current is zero, for instance. This patch gives support for reading the page1 registers (including the offset register) and for writing to the offset register. The DS2438 datasheet shows a calibration routine, and with this patch, the user can do this quickly by writing the correct value to the offset register. This patch was tested on real hardware using a power supply and an electronic load.
> > Please help to review this series of patches.
> 
> Please linewrap your text here :(
>

Hello! Thanks for the review! I'm sorry about this again, I did it for my patches but forgot the cover letter. Won't repeat! 
