Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6224D4576B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhKSSyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbhKSSyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:54:47 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD701C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:51:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so46562730edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y5152iVHll0g+BnXlIixI8+5pixdhUQayUeDmJybp24=;
        b=E33ogDCaVL7hLV1QLSV72rIaY1HIeDnknm3VdcMdNBRzH/MeyvsGUc9/XFaPtsDDfs
         dWgeH4i9BI5q14C74mh5sUSOuBA1irGJkb2dj5jtx0TFggVrZKiOGrmSguZ7pGUJNxYX
         KLcXfobSy+sKBn/qum7nRCa/Qb4FXmzq9QWPo/qppNksogCrcsGWByiuq/Pwqd1yHXWK
         t4hYfc0ROI3dfC5u7TqI5/Iv0Pcq5T8y9gooku406NThOHXjz9hmX009Z7qmAcZvXQe2
         3yoPCGqeMwbHxfRCNtcXnyxVmDXtk3JaihbzFS5TDzfej8dfyxdSbUwvQ2gHnMGnVyNv
         /TPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y5152iVHll0g+BnXlIixI8+5pixdhUQayUeDmJybp24=;
        b=mttBXGcPDlB8m//bVW/QSXZHoQCaaqmba6+b+EGqOmRnHH9B8geT4SsKcnoyS3KsH/
         2tC3I36zxDmNeun2BuBqon6XuxVhW1Z37Q9uXGRth1DvUQl+26lwG2hOVvpRLZgO87de
         CwB0azAtsJzqzRoEQdJcKqz7XhwK+oJ9Twyt6tsF+7j5eRL1Tj7CR53s05hKwzvAn7RE
         RKrVNS/jy2kpDLqiKbJditecUdS35wLFafeIEqq1QpVe/7r894egf1vvgEGSTDa/2+dE
         wDdi66iBrWA9I4a1PAUecoauCok8ojrQhd+XFY48UNxVsoZa+j5zfzcoiTdrnAiPLKW1
         AXbw==
X-Gm-Message-State: AOAM531HANlQwNRri+6QnbNiFEuOdQVaBp+8+0ArprHQrdTIkYzYFzbz
        5DERBcU3rh1vhOhKxBMDnaY=
X-Google-Smtp-Source: ABdhPJziR+03/6XqZfZgaSJIU7yr0BagP6w5l9qrr5XQOZBdA2jXWn7yLc4TnaM4+07RwCFiKcBzqQ==
X-Received: by 2002:a17:906:6a1a:: with SMTP id qw26mr10732467ejc.489.1637347904326;
        Fri, 19 Nov 2021 10:51:44 -0800 (PST)
Received: from bulldog (host-95-252-102-163.retail.telecomitalia.it. [95.252.102.163])
        by smtp.gmail.com with ESMTPSA id s4sm303156ejn.25.2021.11.19.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 10:51:43 -0800 (PST)
Date:   Fri, 19 Nov 2021 19:51:41 +0100
From:   Your Name <alb3rt0.m3rciai@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, forest@alittletooquiet.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <20211119185141.GA396725@bulldog>
References: <20211118202718.GA152832@t470p>
 <20211119085138.GR26989@kadam>
 <20211119122351.GA2519@alb3rt0-VirtualBox>
 <YZeYsip9CD8YkKgl@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZeYsip9CD8YkKgl@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What caused you to pick that one?

My mistake :(

I was reading "Submitting patches: the essential guide
to getting your code into the kernel" and I was confuse dby this line
"See the T: entry for the subsystem in the MAINTAINERS file to find 
that tree, or simply ask the maintainer if the tree is not listed
there." supposing that master branch was the correct one.

I'm moving on "staging-next" branch as you suggest.

Regards,

Alberto
