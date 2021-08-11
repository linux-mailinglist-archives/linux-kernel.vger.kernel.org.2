Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5983E97F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhHKSxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:53:06 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:35501 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhHKSw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:52:57 -0400
Received: by mail-pl1-f182.google.com with SMTP id u15so1744288ple.2;
        Wed, 11 Aug 2021 11:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=atqACq3jxT+FgxnkJZZlT+1do4BoZXlpc92Nz59MhSc=;
        b=hm86fmRLne/rcstDKQSWSP/TJLVjEDISpn7cZ+jLW5tm7DnFnnb5b9HVE/eePKbPjh
         yAEGDe02HPYfcZ/UzH1mtqULoib+lwCioCyKhZPR7sZt4ZNcL9o3m62fuN7f0evYFC6P
         aMn8nRRE/L0nLMB3RY+xyhB8N5MAkW9nMJFCqP6pFt50jP7/+DNFHoYtpBsFBg88o0RS
         Ep0KSjoR5YN7hsVMMEbTYFDjppZDXy3q8hSK0hxn+T+qO6pNd4SnyclMY0T7lrJcxDzM
         rioXyiHpQsGFSkQEvPc77rnue5K413O3UuoL/rpb/6iVyGg4F1jclFlR11RJPxcteKkz
         LZnw==
X-Gm-Message-State: AOAM530pV6Y+A7JbwyFz9++aVDJTDx9UcL/kEnmoHWTweSLHV/LYW2Th
        2PJVfi3WI4zKXaZn5ietdQ==
X-Google-Smtp-Source: ABdhPJxuaSdsfVpnWCyZEsL2nHMzzxcCCNwn4++4QNWpr9qsj7NbD0qVGFMQVhzBSRlV4w7TOIcx+Q==
X-Received: by 2002:a17:90b:1bcc:: with SMTP id oa12mr18429pjb.94.1628707949749;
        Wed, 11 Aug 2021 11:52:29 -0700 (PDT)
Received: from robh.at.kernel.org ([208.184.162.215])
        by smtp.gmail.com with ESMTPSA id y10sm249485pfa.65.2021.08.11.11.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:52:29 -0700 (PDT)
Received: (nullmailer pid 87834 invoked by uid 1000);
        Wed, 11 Aug 2021 18:52:25 -0000
Date:   Wed, 11 Aug 2021 12:52:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, badhri@google.com,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: connector: Add pd-disable property
Message-ID: <YRQcaZITeZeA8vA1@robh.at.kernel.org>
References: <20210804081917.3390341-1-kyletso@google.com>
 <20210804081917.3390341-2-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804081917.3390341-2-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021 16:19:16 +0800, Kyle Tso wrote:
> Set "pd-disable" property if the Type-C connector has no power
> delivery support.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> Changes since v5:
> - Changed the property name to "pd-disable"
> 
>  .../devicetree/bindings/connector/usb-connector.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
