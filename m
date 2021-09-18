Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D4E410552
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhIRJOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhIRJOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:14:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D4CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:13:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id e26so9087227wmk.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=76q8V1XO/uXWgYaoiSEJ8zGvFMP1hD8UrP5IH+LteFI=;
        b=LqPz7SIhuQxfwU+hOnXNmzpfY/lNQledmDJp/3I1AVOu8ZRo2tNa86aiKYd31hzjHp
         nbVHItEHYYVh4mxZ1r6CkepCJPi/DnBDc3VHfxSDX6afAK07F+xfTytkeUtp5dGs6Bx+
         YmTz7p5BTtAH0pj4ediLrs6rmK1Z4Yd3Ac/WxysjRh4HfAnJgaTzeVlw5rrCA0AtnrSC
         igPsPl+Q2svZrxk9WL9LMiWrHCl3uTjRTEpkCEj5rr122mJc4gY9SQpeFHmCVDI0bua/
         RlZFQpgOBe2NJGuE+V9tk+6HFUr7UeFiB3XoswNmzx6o1PooSeiJa9vAqfc1+MFh756v
         L+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=76q8V1XO/uXWgYaoiSEJ8zGvFMP1hD8UrP5IH+LteFI=;
        b=sEUuYBnP6xdm/6bw125pxlLH0bmortwIdWvlHxSnWTV2PwKYPkylANlsZdG+/fDDpO
         yjfQ6TM35xvZyDo3uCC5Na9EHFvJ/AMPwz1BBTWgRzIVu+LVQuZhjyP+fpQqRVOR5noN
         slsJIfyGdAOVzHRTvAhHihrLVHw7JqBbVWry4XyEpX6HNK3gzY/oqQ/SqrzsJdDm6+6K
         ShhBZDdRHUn44FWBySHt8aZkyfULqRnkhe2mx+D3SyqUei3xVEex7Gckou6vakK5v545
         Rdfzb52wPpHPI0QcOGOa3Yo3WpqHusl4uyJHvnJU73d31U1vffOzIZvZpDZ+eISNOwrh
         QrlQ==
X-Gm-Message-State: AOAM533wyWbpDCBp9nz1cGMd5FJImzRYgq0+j3iVueQ8PmQe5ye2T9aX
        8p6d4RI6s9HBs2c2C2mcfLQ=
X-Google-Smtp-Source: ABdhPJy9Ydpd3gzR4aYcZaEGDWJOHipzVUf95UzPZERPDqroefiNjVfNgK0sEPnzQPUabmATjkHSKA==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr14986786wma.105.1631956378634;
        Sat, 18 Sep 2021 02:12:58 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::ae40? ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id j134sm6103125wmj.27.2021.09.18.02.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 02:12:58 -0700 (PDT)
Message-ID: <b62ae16e-5eb3-e51d-dbda-5f0790de128e@gmail.com>
Date:   Sat, 18 Sep 2021 11:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 11/12] staging: r8188eu: remove ODM_IC_11N_SERIES,
 ODM_IC_11AC_SERIES macros.
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210917233048.31677-1-straube.linux@gmail.com>
 <20210917233048.31677-12-straube.linux@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210917233048.31677-12-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/21 01:30, Michael Straube wrote:
> The macros ODM_IC_11N_SERIES and ODM_IC_11AC_SERIES are unused now.
> Remove them.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>

I just noticed that there is a full stop at the end of the subject line, 
sorry. I'll fix it and send v2 soon.

Regards,
Michael

