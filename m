Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8611C3D646B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbhGZP6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 11:58:11 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:52798 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbhGZPqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:46:24 -0400
Received: by mail-pj1-f44.google.com with SMTP id m1so13621651pjv.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 09:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zI7plmiWGse2X1CHO4VHp6XbSpQzNDfX1o+rPvqEzrE=;
        b=ZEzXSYX+jberFKDSCcpcGq/lo6PFyARUytfcUB+yg5YLSWAkQkl6f4HkFstJDawEjI
         /55yqSFfoDBK23fdXGv0F2WtbgpHlqI3dQ9pV4tQ5mX+wWcoa15lMw8Oyr/qP77brORY
         wGyNI3w/g2bbDs2ycFqWeZbr9W+IQ6bbP714wgeJcu/8UO1qq3g1Me7jYNNquccPl4MX
         LK5AR6UYk13oSD6t/eYmRnlxdzC/DFm6BcM6mLGQpq6JePs0dL4ivEPCD2lB3sBZ1V6X
         p6yddCZBeTAN/j0GFwyGltVfixw7D8QH4wd16+kaLldEwBwAvU16H1N1VA5fW3f3tt6I
         p85g==
X-Gm-Message-State: AOAM532FMTFZ1609dcRVUf/L0EPOIkEJiopibMPCnIosXFMIz5jCXk+j
        CoCPN7QrWFoToohNbk7DgNY=
X-Google-Smtp-Source: ABdhPJxQyThOh7PjfsGEo+L9anS/AcjVQ+uwjyh8iLAOS29SWlLr3tIa5bo8hKBw6l9sHStWguy/yg==
X-Received: by 2002:a62:b413:0:b029:327:75dd:c8da with SMTP id h19-20020a62b4130000b029032775ddc8damr18790616pfn.34.1627316811761;
        Mon, 26 Jul 2021 09:26:51 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:7d43:3766:10c6:c3cb])
        by smtp.gmail.com with ESMTPSA id bj15sm121481pjb.6.2021.07.26.09.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 09:26:50 -0700 (PDT)
Subject: Re: [PATCH 2/4] configfs: Fix writing at a non-zero offset
To:     Bodo Stroesser <bostroesser@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20210723212353.896343-1-bvanassche@acm.org>
 <20210723212353.896343-3-bvanassche@acm.org>
 <7bee65ce-f5f1-a525-c72d-221b5d23cf3e@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d12f24b6-7066-f9bb-1b88-6cc23c9c45c1@acm.org>
Date:   Mon, 26 Jul 2021 09:26:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7bee65ce-f5f1-a525-c72d-221b5d23cf3e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/21 7:58 AM, Bodo Stroesser wrote:
> On 23.07.21 23:23, Bart Van Assche wrote:
> Let's say user writes 5 times to configfs file while keeping it open.
> On every write() call it writes 1 character only, e.g. first "A", then 
> "B", ...
> 
> The original code before the changes 5 times called flush_write_buffer 
> for the
> strings "A\0", "B\0", ... (with the '\0' not included in the count 
> parameter,
> so count is 1 always, which is the length of the last write).

Isn't that behavior a severe violation of how POSIX specifies that the 
write() system call should be implemented?

Thanks,

Bart.
