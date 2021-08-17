Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DE93EF41A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 22:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhHQUdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 16:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230459AbhHQUdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629232356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHdS9ueOmb69jsJrcy2jnmQ7X1KObHEiLTLTlPALuPw=;
        b=girTYvkWVIMz3PlsEa4qba25mwA/9+N0g1UPGUrX8suK5BQYpfj01Y8mxRs2Ade2tAnbQz
        5G8QR/i2Q8Ldb943nmbIognJqAqzsYG6NwUdXONzBX0hUYIxLyFjCdYJBiNb4TZKTklj9H
        vPbPgdXcfixZV+Duh9wM7McCjSxE1z0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-KZVDOpi1MjOqvAGkT6Ft4Q-1; Tue, 17 Aug 2021 16:32:35 -0400
X-MC-Unique: KZVDOpi1MjOqvAGkT6Ft4Q-1
Received: by mail-qv1-f72.google.com with SMTP id z8-20020a0ce9880000b02903528f1b338aso450667qvn.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=QHdS9ueOmb69jsJrcy2jnmQ7X1KObHEiLTLTlPALuPw=;
        b=lI+3uexML21VvtXSsvLkUpH/7TCgfHviOBm9f/zdTFRwlkvb/k5wkja9UbchIdX/It
         A+p3pk5onr79EW98R55FGRth5cHbylPnYc571CKi6SlsF8fKh3CheKR7zceeQKAQmo17
         LJpNYWoHZ+L9eV37vGwJdgzoKuYyMxXGihZy6h++rzaF5FFCRH9nPCsqeGv0mVlGuoTN
         2+F2YyBvl+VcN6rBVGFuSFN8xR02ghNXtRMlysGPhdyCcehS9/D4BdWu/GrVjlN7MjZj
         4Ys6W4aTnQU3oC7JU3KeLnQKTjsEiLyVGs3i6hLq68QSMj7du/L3A3l197UU9aOHVDN4
         2MJw==
X-Gm-Message-State: AOAM531Dq//ZgJ+5VAzQDIXPOguKJfAgEuaMUxasF1MKEQvtRJk6WGPg
        u/uE6Az7OoD2abuiOgllYpDKqU++vUsJERBUXm922+Ok4dvL0Fo12DOGUdF/pdZL+mBt2zqtdAe
        5fCAaOjX4RnLFgqMrP9suuLdh
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr5275134qvp.12.1629232353972;
        Tue, 17 Aug 2021 13:32:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygDhxEIqY4Za1qslzDIgx56HQC6qEhIHk2i9Emxojd0+6VzuJVx7K1EP9WMmefEySmnxy/Cg==
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr5275092qvp.12.1629232353464;
        Tue, 17 Aug 2021 13:32:33 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id n124sm2175109qkf.119.2021.08.17.13.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 13:32:32 -0700 (PDT)
Message-ID: <418fdcbcf554d34cc6423a88974f916b64b3664c.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] drm/nouveau: fix a use-after-free in postclose()
From:   Lyude Paul <lyude@redhat.com>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Jeremy Cline <jcline@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Aug 2021 16:32:31 -0400
In-Reply-To: <YRoN0vWFN6Lw22ej@eldamar.lan>
References: <20201103194912.184413-1-jcline@redhat.com>
         <20201125202648.5220-1-jcline@redhat.com>
         <b4da382b17a77b66e45fd374c9d806dac6054e3a.camel@redhat.com>
         <YRoN0vWFN6Lw22ej@eldamar.lan>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may have been, we're in the process of trying to change around how we
currently accept nouveau patches to stop this from happening in the future.

Ben, whenever you get a moment can you take a look at this?

On Mon, 2021-08-16 at 09:03 +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Fri, Mar 26, 2021 at 06:00:51PM -0400, Lyude Paul wrote:
> > This patch series is:
> > 
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > 
> > Btw - in the future if you need to send a respin of multiple patches, you
> > need
> > to send it as it's own separate series instead of replying to the previous
> > one
> > (one-off respins can just be posted as replies though), otherwise
> > patchwork
> > won't pick it up
> 
> Did this patch series somehow fall through the cracks or got lost?
> 
> Regards,
> Salvatore
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

