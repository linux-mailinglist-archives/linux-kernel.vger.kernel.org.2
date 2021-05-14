Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33A038055B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhENIkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhENIkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:40:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76361C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:39:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n25so33858165edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6uA/UUkc0ViJ/2YRaUldx05MrsQE2UfYmoMseM3ZwZM=;
        b=ZK4hqy9lY4WOC7ITURSwXwumBMAF0mS4b8rWte1LIqOdoROqHS3jnN0ClnzNwL8+Vk
         9LnXzZsgtmb5kcEwYUFimU5rDxwfqH18XCl2QFgdqy05uw824vl9eaTEO2OEqxNWGAnl
         I5lTIpcMYPgsEWa3SeUA8rmpGQb244riN6vNKtoP9C1elotQEMxJQ7CMUVPutYwsow4+
         yGu3XxCIu6jYdCncsC5STa+WttgvhhBj0Odvs8PiqSAvHzwgnWk/Cw2woWne4S2O2zXo
         8TQaQ1VMkzQexTJ4LBSug+QJT8vJnriE7pmXPTEzRwrUauX/oZYddTPObjYqCVrH8/K2
         /rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6uA/UUkc0ViJ/2YRaUldx05MrsQE2UfYmoMseM3ZwZM=;
        b=mwKmMJqMcEwlCrssz6gEEjftK2VYe8nMsatlPD2+2/9m5/T63fKjPALycD0t+nFUfw
         9xoebfnFj6EYwLAwic7PzrVtfqZKKBqAR6n/o2iqnUfTIp0S/W/hdC604OFhg8DzpNKA
         ygKv5FyAJdWrr+SEkCDoPjXddDVZtWkPhGK0oXIpgJ5gnJkfB92WQSpesWP9nFo07JlS
         tmn2EBYpoHXE1+g0dPqx3EgVhXtrNckZqC/w15BHJfbwq23oY+C/bfsFv1zPIFm/MKUf
         qqgd2VCTS2+WUYjDnfMiClW+uPg1gPKOcxyGsb7mHecj4cpML2/oUUEC5s6KfhrecEon
         KWBA==
X-Gm-Message-State: AOAM530fwtibMKn/Uj/ssF/1kYMYqgQC9lefCzEwk9MvQvyvxuxAv9Qc
        h6q8XMtgL9q94MdetNHqiCJcgVhfz18V8A==
X-Google-Smtp-Source: ABdhPJwKaVtECdy7q5WpBFC70sl7tYtv+CfNLH+hxu/BPK5uwBP4JU6QC8oZTF7hKzh5G8ma1j/PRw==
X-Received: by 2002:a05:6402:652:: with SMTP id u18mr54957386edx.388.1620981540181;
        Fri, 14 May 2021 01:39:00 -0700 (PDT)
Received: from agape.jhs ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id k5sm4552527edk.46.2021.05.14.01.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 01:38:59 -0700 (PDT)
Date:   Fri, 14 May 2021 10:38:57 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: staging: rtl8723bs: questions on TODO list
Message-ID: <20210514083856.GA13800@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'd like to have some clarifications about rtl8723bs driver.
In order to make this driver ready for moving out of staging
I would like to know:

- find and remove remaining code valid only for 5 GHz. Most of the obvious
  ones have been removed, but things like channel > 14 still exist.

is it possible to remove all 5g code, even the one related to power
regulation when on band 5g? As far as I know about this card is that
it doesn't support 5g, so may I just delete all 5g code or there are some
constraints I'd take care of?

- find and remove any code for other chips that is left over

Ok this seems clear, are there some suggestion to do it safely?

- convert any remaining unusual variable types

Ok (but feel free to suggest anything)

- find codes that can use %pM and %Nph formatting

Ok (but feel free to suggest anything)

- checkpatch.pl fixes - most of the remaining ones are lines too long. Many
  of them will require refactoring

Ok

- merge Realtek's bugfixes and new features into the driver

Please, can you explain what one could do that?

- switch to use LIB80211
- switch to use MAC80211

I think I need a few details for these last points as well.

Do you think that one will need real hardware to complete
these tasks? I don't have rtl8723bs card at the moment, so
I think I will focus on those TODO activities which
don't need it.

thank you in advance,

fabio
