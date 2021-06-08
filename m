Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC10139FFBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhFHSfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:35:47 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41686 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbhFHSd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:33:56 -0400
Received: by mail-ot1-f50.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so21291713oth.8;
        Tue, 08 Jun 2021 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oh1ALOBdiSICov5E64J+w95vSj9YVwXhKnwHIm+LmsM=;
        b=H2PPCtO+EexlXhQXuVkhrtgGp0ETqvRJAGFfjY+MHzML0GPplHXm9ygGlHaMCwtoL3
         2nKgCNIsnpFft7xKOgrskjXQkhB9HhFo/jwscuc48c8EEiNwWnEpRZ1bQu9psR63DcU7
         Rws+cJsCLojeioBmJPQ1oXhaiBtPLddO00lsR0xOd9mqnX5Pn1sAQ1HNjNqfrYRxMzyO
         8ijuUD8wHBUvPLSiheDlsLi/HA7RupFwm30tz/ZpSyds4CD8rt/ZrfKwt2ikVWd8TP3D
         sfDHXv13r/I9C2g8sUDmUsAz3Wtvu48wjMzka6RmbTawPZuG5Djl0a94SSt/R9PuiYFa
         +Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oh1ALOBdiSICov5E64J+w95vSj9YVwXhKnwHIm+LmsM=;
        b=Js6RrP1LAYC4gI+4OQVFI8ayg5sPl/eAvDfMD+XUxVnAzmvXlmt+ZN3uYYJZQ38ojn
         CbKtKoudZyO5mJArpXAuHg9voTJ1OLPfKvELkMcjGxUXBlgOi0/SxKA55WZ8dAVTa8uw
         bHXmNI53G9ZxXdMEdxRLVsblGA1QLcEn+6YNEhmaoyKx+8o9jlmTVrAMNUwG5iUtG248
         euHZygzNdHnmXZ1r1i/6O+SfVuXz8QM+/1uu5appLX7Z+Pn8e+PPVlck+l4PRcUORYIe
         txNnKi4cJkrnPkVTwsKfYI3dDRJ47HmVMSljj4JJq33tAZP2UAyx25ZneW18jsgYoqE4
         vkIQ==
X-Gm-Message-State: AOAM532L8n5WzOcpMtuXvoUzAPR4dI7ftBvkbQP4bi/bsgfJxP3tWYC/
        MyXL8oV9lt7mkQXjgfyFaXjZTRf4Sek=
X-Google-Smtp-Source: ABdhPJwoimhZDFBmHPUi2kfeq6UIdwZ3u5xg8+fRuPOH08pN85Z9uGNRFc7ALrzSus0cjZ+0ctANAw==
X-Received: by 2002:a9d:2904:: with SMTP id d4mr18847414otb.238.1623177063222;
        Tue, 08 Jun 2021 11:31:03 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id f63sm188594otb.36.2021.06.08.11.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 11:31:02 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Strange problem with USB device
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        ierturk@ieee.org
References: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
 <YL+veAlZSCrniOyl@kroah.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <5299a951-7d58-24e7-80da-56e72f65430d@lwfinger.net>
Date:   Tue, 8 Jun 2021 13:31:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YL+veAlZSCrniOyl@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 12:57 PM, Greg KH wrote:
> 
> Loads of things have changed since 5.3.18, that was a long time ago :)
> 
> Are you sure this device doesn't need a "magic" command sent to it in
> order for it to show up as a USB device on the bus?  That sometimes
> happens :(

I am having the person with the problem try an openSUSE Tumbleweed rescue system 
to see if a 5.12 kernel can see the device.

None of the other Realtek devices have hidden their USB ID behind some magic 
command.

Larry

