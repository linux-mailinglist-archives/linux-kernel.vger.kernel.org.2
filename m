Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B116E3EBC68
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 21:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhHMTHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 15:07:13 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35448 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHMTHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 15:07:12 -0400
Received: by mail-ot1-f41.google.com with SMTP id r19-20020a0568301353b029050aa53c3801so13212591otq.2;
        Fri, 13 Aug 2021 12:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ArjQazBZbQdeIH39HLGa8jeC3oS/ljBtvGgjaEw6/Os=;
        b=QjRmtjz/8IjCxmaRBF1VhAzk9yeLH8HXD/n34HmtnYHoDzxNYOmjlxPS6uE9e5khw0
         2avL0znDE7qQjmlutHhGCK3HZ1eSQxEEjsLLxULy06yvoqGuAX2tRAQZyVWQB7m1ltQ4
         YuXVifXpPBiCj0Va6XiU+6IhrG7NnPi+RZdsJlsFkzhqkThgyEHs3MzN5ck/wi64O01z
         QDCuArDfzQFvSbqeisbtwcUSDdw/ehPEV6r5TJYomzSpS2kTsMHpEvXNHxBLzeCRul+W
         d6rDF2CfcaX4AFcykmqwBuMD/ulQoSt3Iqf3EQGH0U1JRj2EH87iyiYR0TeKA6RCbc/P
         5cLA==
X-Gm-Message-State: AOAM533jyKpdZ+9kFcKG/qiSWAcDWBgxKmC4++m+jsE6aUanN1MFt/jU
        s0ktTepnrIVT8haQqHEQ0A==
X-Google-Smtp-Source: ABdhPJz9ZAZlRamZeISVVu7vb3LbvRZf0qyA3Q6J7pcIUhSezze+aX5cgTIdWqtPGja+UBCqpnbsCg==
X-Received: by 2002:a9d:5d14:: with SMTP id b20mr3397205oti.307.1628881604631;
        Fri, 13 Aug 2021 12:06:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m6sm469321ote.31.2021.08.13.12.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 12:06:43 -0700 (PDT)
Received: (nullmailer pid 3878481 invoked by uid 1000);
        Fri, 13 Aug 2021 19:06:43 -0000
Date:   Fri, 13 Aug 2021 14:06:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1] of: property: fw_devlink: Add support for "resets"
 and "pwms"
Message-ID: <YRbCwz0uUYYnQYQv@robh.at.kernel.org>
References: <20210805223729.1196047-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805223729.1196047-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021 15:37:29 -0700, Saravana Kannan wrote:
> Allows better tracking of dependencies between devices.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks!
