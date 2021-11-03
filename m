Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD77D444655
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhKCQ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhKCQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635958425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=23KSov31hhwgD0j6JIfZCU2ET5zbqEjxHYDDTc6Nniw=;
        b=F/o35Amsw1OElwW0I1KQmRvk1EAlWGbZS9cbAcXWeLHkqNT8KMw60pkUNP7/17EXDOmH3u
        jK9L5aty/S8FgrlaHEMFtSl9RyY3TcnCduha3+M1Ez8BffOS/lyxxj7SU+i0xVWuU2RtD3
        RiUzDHsEVZDWe0YDTLo1bBzKrWD6IlY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-jZ8SUVRXNhuEB0geP9RAQA-1; Wed, 03 Nov 2021 12:53:44 -0400
X-MC-Unique: jZ8SUVRXNhuEB0geP9RAQA-1
Received: by mail-wm1-f71.google.com with SMTP id z137-20020a1c7e8f000000b0030cd1800d86so1331096wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 09:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=23KSov31hhwgD0j6JIfZCU2ET5zbqEjxHYDDTc6Nniw=;
        b=RerFOgmmmlOYbem+EjI8FxAer+lBOhxWnXrpfnx6oflRL4CRmUVd7eGigoyqi+iovC
         qru4P4Ook3Ntpg1RDIAeSb9T4kfIA8n04rszB0IioV1RSLY2la3gt1N7O9JVJIduYJbU
         IZpyMLBhAwnY1JKONZ5nm+of4SuXwsjWmdxwSJqs09SFhf6cKG3OKM05wv05vAcsJ4Ir
         JIvb1cPJ/JbP1MOFRMWcu6tMHkvpkbfZVKonZOHGNVCxVMXjRN5ssj1JVZ7dJDVITWB5
         QmDCYE4AkNMJjmDgG5ok78kYRhqEYVtsJehEiG1Klz4iYbqK02DSv9HNNOq3zkPcaPqU
         EHnQ==
X-Gm-Message-State: AOAM531WkHVGz5n2wvXhM18NMOhm3VJdRKtk/jbtzVQN9ir19DhmOvZm
        v9kx9wN351nbB1HXRBKyxU6KLCVNmWMBdgHaHn4p32V23Z7dnC/pryZSUgCMB+QXuTasdxLqboJ
        JkmDOWxcIcRmL1cfqtmcwcWHy
X-Received: by 2002:a5d:47a8:: with SMTP id 8mr22610174wrb.80.1635958422901;
        Wed, 03 Nov 2021 09:53:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMEhUBVCOvyzgW0CpapaniDkPu+MHQ/15rrXzMeRd+OA+dm5tgwkP9/+GBInIBcMFJm0sS2g==
X-Received: by 2002:a5d:47a8:: with SMTP id 8mr22610150wrb.80.1635958422742;
        Wed, 03 Nov 2021 09:53:42 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id r17sm2556469wmq.11.2021.11.03.09.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 09:53:41 -0700 (PDT)
Message-ID: <9ab3e853d445ed8f7c2166df620dd67bff95454d.camel@redhat.com>
Subject: Re: [PATCH 1/5] drivers/mfd: sensehat: Raspberry Pi Sense HAT core
 driver
From:   nsaenzju@redhat.com
To:     Matthias Brugger <mbrugger@suse.com>,
        Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Date:   Wed, 03 Nov 2021 17:53:40 +0100
In-Reply-To: <d3de34d9-a144-f955-bd41-13384c9a04c8@suse.com>
References: <20211029215516.801593-1-cmirabil@redhat.com>
         <20211029215516.801593-2-cmirabil@redhat.com>
         <d3de34d9-a144-f955-bd41-13384c9a04c8@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 (3.42.0-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-11-03 at 17:33 +0100, Matthias Brugger wrote:
> > +
> > +	sensehat->joystick.pdev = sensehat_client_dev_register(sensehat,
> > +							       "sensehat-joystick");
> 
> Why don't you use devm_mfd_add_devices function together with mfd_cell?

To complete Matthias' comment, why not use simple-mfd-i2c?

-- 
Nicolás Sáenz

