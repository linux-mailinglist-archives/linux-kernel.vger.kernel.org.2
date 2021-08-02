Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830E03DDF9E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhHBSvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhHBSvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:51:47 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D00C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 11:51:37 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id r1-20020a0568304181b02904cf73f54f4bso1193732otu.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=svJkIty/ZqVJuJga9dG1X+yiI53hTyzCIsAln5flC+8=;
        b=GTHm/zAFffONfXf4W1Ae3Q8OLLoD0T4iJrG0lU46iafYHvH8YEZ2O5qsMTWKnLwWBj
         XUo6YN+dz8Y+dQ97xLNAhp3dDDtMzcsScYTsL6jmOs03jMf3+/LqmY5/T89wbTTOY9HY
         uzHJhJHsrFbnplpmBxkBpjX6+8d55j7DloqkRTOqXB2WgyR8S/04unyVXylBS83KEIsx
         5UDh1QOYeSgM3F6HVnR7ciiOQN3JIPZw+KAiHuCWOezWm44fSvt4rUKqmWgb4Rc/E8MG
         4ayVxJkM/UI0oZLEPB0sZAf8Meh3zff69gOZhlmyRP81DjzW/TdGamdD8wPQxtpUD94g
         HdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=svJkIty/ZqVJuJga9dG1X+yiI53hTyzCIsAln5flC+8=;
        b=C5Kkd7tVQjONQCGdppyXQTIePQAXPv+31XSn3GyIFtYOLCSZ5vCaGhuou+w+qtYO0d
         fyFWNbLqFs/teEQFGOpOONXMiVZmm+g771O9FR4UypXsGeWzgrzsmrZz9T3m7smo4JJx
         Nc30YoSacyZsipOOeiIhH8rjX6MJkp+4rAQHzYI9mveQ7Ad8BRSt/1bKZ6Vrg79mDgdf
         z1d5/Gny90NxwVdSsblCOgbj1ZLV82VE/T87vn16PX6ZCD0XTIX1+I1F9iy1q9Alozg2
         VPNfU0BHYROT53bAgfoU7vXxgqAnst3uAwluhkZE1TMCLvefFHq5y5N7q5ddNBZLPuI4
         2Adg==
X-Gm-Message-State: AOAM531Jj3djznS7CPNB6d8itRMBdr4vmiohNt835YHGZtdgiHIovsju
        Eyr3DlT27SGzI6bW5GMCPl+0iVu8aG4=
X-Google-Smtp-Source: ABdhPJzE+iW32I6J61bigAlcYHMc2+WyKCDzFS2Id18o32GCEqIbeDaNjjfj73FeNr8csZuCxGIyAA==
X-Received: by 2002:a05:6830:1be2:: with SMTP id k2mr12503576otb.285.1627930296849;
        Mon, 02 Aug 2021 11:51:36 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id y22sm873744oie.27.2021.08.02.11.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 11:51:35 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH 0/6] Clean up some extraneous wrappers and some empty
 routines
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210802151546.31797-1-Larry.Finger@lwfinger.net>
 <20210802171947.GA1405@agape.jhs>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <185d72dc-e916-0ac0-9a79-9927395f6078@lwfinger.net>
Date:   Mon, 2 Aug 2021 13:51:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802171947.GA1405@agape.jhs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 12:19 PM, Fabio Aiuto wrote:
> what these .rej files are?
> 

A mistake on my part. I will resubmit

Larry

