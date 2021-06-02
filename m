Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F02398773
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhFBK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhFBK6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:58:23 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB40BC06138E;
        Wed,  2 Jun 2021 03:56:21 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c3so2211859oic.8;
        Wed, 02 Jun 2021 03:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/47W/OKjxWYCnqnbbKYahszrZqkBdL2uMz2vtDHF81o=;
        b=Wk7R+3c4RyoAUhByFTAB/zOFTmIL1dQrYvrEZ9MlkrNAV7Y5pAOGrndLj6Artks05z
         q1Nnf9ELewx/s+AbcsbGJ/X9eeL7G/trJhnuZw94yHptOygbip7GkWQWnq9OsbMXyWhD
         LUE5ESAL9Li0We2oBhauk1/Kbe1PsWqY/GB1x7CwlTITMdXqiXZJWNjfXtEQGPrSUoO0
         I38AKk9n3NgBzHy77/fsVDTOcXBfEMpblejneafFSK6/bEdBX9ZGfoUe1U66gOOrpPWj
         nO33//Cqz7h8xO3vPUtC0s+KuMwVCQzPvgqKyGohK69i/HIvYiQ+1sCe4aInkVg2+wZ7
         HWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/47W/OKjxWYCnqnbbKYahszrZqkBdL2uMz2vtDHF81o=;
        b=Dw+BBVzkS0tsh2OtmOF00cQG0pHfFl7M9aFcvFzXmvITw9ZnWY4MmPBNFzTBkoSYA6
         w7JUBS/u0wybjEf4qWj5pcy/9MSoJ1kYjs4UHW3tjO6bgfKN0EXoZzuyagVsBGdbMRjQ
         o9uTVKgLUBZoGHXGB2tNHlEn0FEraJ5H+ha2WRShd4AY7mftZ9ssJCuliMHyLx9gHu86
         UzUP4KQHhsyluvjUnkKE3E6jCOv363ENJtk2Av+HN/3BeVusj+5R8n5UX3wtp7ZLWRJX
         KwK+v9xHx5FIiOYSDzAVi8zDxAtt4HvAPCouk8TVK/rRy2tC5xHt5psUt/VzUGiux8NF
         gVtQ==
X-Gm-Message-State: AOAM5306OzT3V5bkLz30XOX63p+v0I5CVXDP+LKXcPkTH1+jJDNwcDhh
        7WZZBr029Vcj7yvwK1sWf6o=
X-Google-Smtp-Source: ABdhPJwgWit1A4hGoCoGOMzD+KLbNV4Gk7s62w1bG82dN5Xj0QKrgIRDLCfxQ2D7XUmvtx+KAoLbuQ==
X-Received: by 2002:a05:6808:5cf:: with SMTP id d15mr399174oij.15.1622631381360;
        Wed, 02 Jun 2021 03:56:21 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o20sm4310047otl.2.2021.06.02.03.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:56:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Jun 2021 03:56:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Daniel Nilsson <daniel.nilsson@flex.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] hwmon: (pmbus/pim4328) Add documentation for the
 pim4328 PMBus driver
Message-ID: <20210602105619.GF1865238@roeck-us.net>
References: <20210601164320.2907-1-erik.rosen@metormote.com>
 <20210601164320.2907-6-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601164320.2907-6-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 06:43:20PM +0200, Erik Rosen wrote:
> Add documentation and index link for pim4328 PMBus driver.
> Update MAINTAINER file for the driver.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> Acked-by: Daniel Nilsson <daniel.nilsson@flex.com>

I got a message from Daniel, marked as privileged, which I can not
use. Please drop the MAINTAINER file update; that will have to be
handled in a separate patch.

Thanks,
Guenter
