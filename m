Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1087E3DBCE1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 18:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhG3QKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 12:10:00 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:40834 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhG3QJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:09:59 -0400
Received: by mail-pj1-f42.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so21455636pja.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 09:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ouYPDb0qEkKTot20JTw6oz1rh+8dwJEA5xvkVI3FvM=;
        b=Q6N2oVmEdWwl+oZrJ7O6yBNKjkpxjw9g3BLTMTJ3Rtmd9fpBw7oV94XLlxtaR50T5Z
         4RwZr7r3nm9/d8a4B5Xo6143eEtZH8L0rg9nRerDWCJr6miBpYumagwo7TwUlkWiAcCd
         DKOc3MrxIt91909E0ptdAF2/Fe6ECxzx/LMY+JfM2j/16BYto11mZ3UTFHs4JP43gCxP
         RX0YUL4NYauMUpskkKX4lrWlsnFhQzOCGvDxZICHCbisLmpb+CYw7HArmcyx8092tizD
         yZb/Ae2v8sT/RS1mz0IMIVWxFcb4JP42+LVU9H8ybA2lVWxYzj5oHKyiaX5BvoxM1AVg
         6IFQ==
X-Gm-Message-State: AOAM53281JNc2NnW2PP/++1fyi7gLbXvn8kzZmav/Bv70amloG2fJvxK
        LBEJ9W9EVMxyNLX6447R0KY=
X-Google-Smtp-Source: ABdhPJyArVKL3GjDhjgm9wOGrE6/XviGkQYmIrzqNI3orOLtPrdy1BhfCK7PQtdX+ylJI/nTIQg56A==
X-Received: by 2002:a17:902:c402:b029:12b:229:f4a with SMTP id k2-20020a170902c402b029012b02290f4amr3205880plk.54.1627661393071;
        Fri, 30 Jul 2021 09:09:53 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:684a:6173:abee:6f13])
        by smtp.gmail.com with ESMTPSA id w186sm3044033pfw.106.2021.07.30.09.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 09:09:52 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] Restore the kernel v5.13 text attribute write
 behavior
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20210730033504.8228-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <728d8149-2202-1324-b8c4-fca17af69070@acm.org>
Date:   Fri, 30 Jul 2021 09:09:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210730033504.8228-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 8:35 PM, Bart Van Assche wrote:
> This patch series restores the v5.13 text attribute write behavior and also
> adds unit tests for configfs. Please consider these patches for inclusion in
> the Linux kernel.

(replying to my own email)

The build bot reported the following for this patch series:

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in fs/configfs/configfs-test.o
 >> ERROR: modpost: "do_mount" [fs/configfs/configfs-test.ko] undefined!

I will fix these issues and repost this patch series.

Bart.
