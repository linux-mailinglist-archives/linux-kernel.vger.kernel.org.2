Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B885C3DD713
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhHBNac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhHBNaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:30:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4D5C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 06:30:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z11so2050526edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 06:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jrreXR6UtcIQ40BKCYv/SEEKLdouMTALz5I4T+6sWrM=;
        b=aNyBU50Us47KWtvrCC7mIgnvgP1OgTGesTZoLa+PBWAv3gHMDiZDNvZj+Czcx7GPQo
         5+nFDcAlRfrcTrD0oHT8CaJY+N7FMojj7eQmDNxFRUw6ef8dIP7vWau6c7R2jQCYQeFj
         GhF2UJprkDEVpPyU5IWGbWZw9ijzhsUw4bU5oNHOrpdp/hB713lgPVbXojCkbciUSMi+
         O8ZkzaaZWqYlIcVp+hZlOs8gF52Q90SZwvMtY8I3A5dC/+jjroyAldAs2M3kcUfM9rOz
         7DhDBcnL5H62xi309FWVrxSAS16oLgepMAw/QTZWCRwEXrAUE1EbW3Y0VefzGvDzVj8/
         lZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jrreXR6UtcIQ40BKCYv/SEEKLdouMTALz5I4T+6sWrM=;
        b=ZdSNrjqJIJEwXlh4KrVRRHEyQZ16cUNdn1PQT/+iFYeGVGof5x0rpfRbW+9EJOrH6k
         Et7LpjvChyC5N5Nubey+0unp+iMiT3Sbu7UspFNfr9TK61napRbQgvsi0SUooGWZeSj9
         jkmV8KERObrLz5cvN/kjwLz8KS6TUIpjS5+H/5PqfeSgSds7yr7b/mtoK8ckl0dMoDTn
         LOTUoaWjMia8iZsy8eYNZj/gnkl7MovffoYiMox/BP0nBXAO1J3RlQqyKSdw18BejXgu
         7dn6nKrDYx9EpyYreHq0MH78zfzbJqk5pNCX2nxGfcvvSGRLxy5jGoovvAEzmjNLnxne
         fwkQ==
X-Gm-Message-State: AOAM530e9nrw5AsZnQt/0VsvAAaTBe4GAqje9JvYkm5I7/Eyf9WzV+Bo
        nIQ0kapi8OvayrPiuzq6AiM=
X-Google-Smtp-Source: ABdhPJyWoi3s/QzC/UVBQzWia2WycF5Acx1lqCUh74Zj0If1008XEGMlcCZzdcQ7OGuAXmr5W0pDkw==
X-Received: by 2002:aa7:cb86:: with SMTP id r6mr19113930edt.181.1627911019046;
        Mon, 02 Aug 2021 06:30:19 -0700 (PDT)
Received: from agape.jhs ([5.171.81.207])
        by smtp.gmail.com with ESMTPSA id d9sm6016267edu.19.2021.08.02.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 06:30:18 -0700 (PDT)
Date:   Mon, 2 Aug 2021 15:30:15 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: rtl8723bs: remove unnecessary parentheses
Message-ID: <20210802133015.GA1419@agape.jhs>
References: <cover.1627656773.git.fabioaiuto83@gmail.com>
 <fca83a857ebb158cf395ea31f1834c04402c39e4.1627656773.git.fabioaiuto83@gmail.com>
 <20210802130551.GY1931@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802130551.GY1931@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

On Mon, Aug 02, 2021 at 04:05:51PM +0300, Dan Carpenter wrote:
> 
> Please fold patches 2, 3 and 4 together.  It counts as one patch because
> it's "tidying up the condition".
> 
> regards,
> dan carpenter
> 

ok I will next time I'll be submitting a similar cleaning,
they are already in staging-next...

thank you,

fabio
