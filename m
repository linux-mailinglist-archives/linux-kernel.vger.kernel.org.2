Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5CA39FFFD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhFHSiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234345AbhFHSfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623177237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NA1BPgHQyRJIVWyu0CSOgPICWGf6DW3whf9PSBQNJeA=;
        b=XZP+/dC3HxLFdVX7M1nPQzhE6dUXDzqnDoE9BPLQl3cCCpvVWGL1Ijf2qckzMHsJVsxMru
        AtMGvxVBkh4nZjvCVCyZBBb/4VhwjRS7x19+LeuN3tyDlRkOymm60H2Tj8zkLpS8k4R1iN
        /Oj9661y8IFYwxnK+q8AHxVYkARGfgQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-VQGy_37uO2qU0jKjF7Vl8A-1; Tue, 08 Jun 2021 14:33:55 -0400
X-MC-Unique: VQGy_37uO2qU0jKjF7Vl8A-1
Received: by mail-wr1-f70.google.com with SMTP id x9-20020adfffc90000b02901178add5f60so9788274wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 11:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NA1BPgHQyRJIVWyu0CSOgPICWGf6DW3whf9PSBQNJeA=;
        b=NnRChvZGra45+tTBuQIkMIJlQX+zzcGntFmiNZwsCT92ZUqgypbfvoCs6jXXOpAbdC
         GoXgWKrmapN3meL+iszT6rJRHn1zl/zcIVF15MTPDsRyQuqNn5CNfKskDX+0IEQEUEyH
         BSOrZ6FCrTDjQ4QMad7JMbKH50HglH3Z0GVj2PSFidmUsWauPgtcnBp9G7hxb8ENilb5
         WX3PbLyYHh3JFo4+fXkvQQNRRgsKxioh47uBkiv2oMkk1vybBAFSnuYelhGbF7BA1lsH
         L+1sBRY9lsvvMjJpbZ8Ax7dDTI2btyo+Zc1Zqmv2lEDKu3nu06pNgKMbfvWagrskHeq/
         gwCA==
X-Gm-Message-State: AOAM532RDdqn2Oge9oEBYT6oYXIyJEZzm+Ncwdl9KD2HCVcNr8zXSK6n
        iTsR7Y1msxN7dVga6b8wiew21PEjV+NdN8PQ/wVim9nDJ+YdUWN3rCz6NRoIKumesTRWsAAUk1v
        H7Qd9N+pe+4zCJ50yg532CToP
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr23301907wrw.276.1623177234741;
        Tue, 08 Jun 2021 11:33:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxolUo5VoDb13plhCQHkgJSDwNMTLQJUeGmL8+giiwp31vBjXTtL2ZHi/MaR4GDgg9Opi/tA==
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr23301893wrw.276.1623177234553;
        Tue, 08 Jun 2021 11:33:54 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f? ([2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f])
        by smtp.gmail.com with ESMTPSA id j1sm18475044wmi.44.2021.06.08.11.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:33:54 -0700 (PDT)
Message-ID: <e032ee6b46097ded860e680e913827d0a3a1938b.camel@redhat.com>
Subject: Re: [GIT PULL 1/1] bcm2835-dt-next-2021-06-08
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 08 Jun 2021 20:33:53 +0200
In-Reply-To: <4f3bf1bb-1544-85f4-0539-033f36f86d19@gmail.com>
References: <20210608100543.691185-1-nsaenzju@redhat.com>
         <4f3bf1bb-1544-85f4-0539-033f36f86d19@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-06-08 at 07:21 -0700, Florian Fainelli wrote:
> Hi Nicolas,
> 
> On 6/8/2021 3:05 AM, Nicolas Saenz Julienne wrote:
> > Hi Florian,
> > 
> > The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> > 
> >   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-06-08
> > 
> > for you to fetch changes up to ca5909b7fa6af9c7b9a215a8708926e44345a220:
> > 
> >   arm64: dts: broadcom: Add reference to RPi 400 (2021-06-08 10:44:36 +0200)
> > 
> > ----------------------------------------------------------------
> 
> How about:
> 
> https://lore.kernel.org/linux-arm-kernel/1622981777-5023-5-git-send-email-stefan.wahren@i2se.com/
> 
> can you add this to this pull request?

Sure, I figured that since it's a DT binding it should go through RobH's tree.

Regards,
Nicolas

