Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060FC31B4E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 05:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhBOEzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 23:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhBOEzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 23:55:46 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F36C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 20:55:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e9so3181305pjj.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 20:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyiui+ZJREM10j4I/3XbZN+Nk8A1x3pI6yY99YBVenI=;
        b=sLJA+zBygCwbsA5iTTM5nCM8rZh1QCw4jgOUVcKN3LnoUHIgcNopMyAq59n85nIk0W
         /jmhsDnfehES7dBdtcJCZxQ5BwX9q4frM5fuVdM8UKdrfSfJKGR8n9BhhMeS/uGv0a8h
         qT8hpZ+2l6iq7IA0/4I+BHjum+FlltHPRjTvuabWR+Wolu79wjwmZb13trfCB0aZBJT4
         WayjnNTd2Zf2A7DMHF3JrhFw7J586MlV4n9onrZxFZBhEi7LXTzTfZ7O7w5TBXXyTju9
         awWdaBHOmV9tkGBnd9uWPh8AHdP8AEqDR5kno1H6eQF6VMNHOWTTSQ227MOcW9puq3jX
         9rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyiui+ZJREM10j4I/3XbZN+Nk8A1x3pI6yY99YBVenI=;
        b=jUw451yh6a0/XqpfEVyVmeJ3768JbF+wQuOpB6gQRCVEzk8+hhtDEaolbNUbzS2BeL
         8h/DspRAWzIsRy85H8bgkrwc6ZgQLEcGdT1tzfBFCHtDF0BAShokqei/uEc06H+BEzJS
         Udd8RRrukgSWPcu/RCWDmQAupJrRPq+xlFFL9ZNt0T3aX5iReUEGXQW09K23vQUa7T46
         aUX69hO9IuIEyzpfcXwWtDBvUUFRRg48piQbDCe4exTrWrlwlgvn1/nkPgxlPnF8/sXR
         g5o6aFXruJ+vJN7353RFyGyzTfbw2lTGkWuAIQfLGaoqxl5UyrBcvStyWYuGMnxt4Tq2
         shlg==
X-Gm-Message-State: AOAM533XLFZDkHU8KKZ3Hf9S12N4BFNt5nvZIK2L36vOl3CK1eE25Yag
        BQaKcz/sB8MqTPbc1BkOeyaigXQquFPw5r7R0yQ=
X-Google-Smtp-Source: ABdhPJzul7kiU7LRG7AszfKYaACrL80qypoGh1xeHvQLcpt14XvqcwgaLaLR6mQDyJkWKdtvrHVic+5E/COC6DtzoFs=
X-Received: by 2002:a17:90b:3741:: with SMTP id ne1mr8119738pjb.179.1613364905333;
 Sun, 14 Feb 2021 20:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20210212222304.110194-1-mgross@linux.intel.com> <20210212222304.110194-4-mgross@linux.intel.com>
In-Reply-To: <20210212222304.110194-4-mgross@linux.intel.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 14 Feb 2021 22:54:54 -0600
Message-ID: <CABb+yY1MLxArMY7g7HY06Tn5aABwpmUuXN9KddHZpW-_Mmu2iA@mail.gmail.com>
Subject: Re: [PATCH v6 03/34] mailbox: vpu-ipc-mailbox: Add support for Intel
 VPU IPC mailbox
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, "arnd@arndb.de" <arnd@arndb.de>, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 4:23 PM <mgross@linux.intel.com> wrote:
>
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
>
> Add mailbox controller enabling inter-processor communication (IPC)
> between the CPU (aka, the Application Processor - AP) and the VPU on
> Intel Movidius SoCs like Keem Bay.
>
> The controller uses HW FIFOs to enable such communication. Specifically,
> there are two FIFOs, one for the CPU and one for VPU. Each FIFO can hold
> 128 entries (messages) of 32-bit each (but only 26 bits are actually
> usable, since the 6 least-significant bits are reserved for the overflow
> detection mechanism, more info below).
>
> When the Linux kernel on the AP needs to send messages to the VPU
> firmware, it writes them to the VPU FIFO; similarly, when the VPU
> firmware needs to send messages to the AP, it writes them to the CPU
> FIFO.
>
> It's important to note that the AP is not the only one that can write to
> the VPU FIFO: other components within the SoC can write to it too. Each
> of these components (including the AP) has a unique 6-bit processor ID
> associated to it. The VPU HW FIFO expects the last 6 bits of each 32-bit
> FIFO entry to contain the processor ID of the sender.
>
> Therefore, sending a message from the AP to the VPU works as follows:
>
> 1. The message must be a 32-bit value with the last 6-bit set to 0 (in
>    practice, the message is meant to be a 32-bit address value, aligned
>    to 64 bytes; but this is not really relevant for this mailbox
>    controller).
>
> 2. The AP adds its processor ID to the 32-bit message being sent:
>    M = m | AP_ProcID
>
> 3. The sender writes the message (M) to the TIM_IPC_FIFO register of the
>    VPU FIFO.
>
> 4. The HW atomically checks if the FIFO is full and if not it writes it
>    to the actual FIFO; if the FIFO is full, the HW reads the ProcID
>    from M and then sets the corresponding bit of TIM_IPC_FIFO_OF_FLAG0,
>    to signal that the write failed, because the FIFO was full.
>
> 5. The AP reads the TIM_IPC_FIFO_OF_FLAG0 register and checks if the
>    bit corresponding to its ProcID has been set (in order to know if the
>    TX succeeded or failed); if the bit is set, the AP clears it.
>
> Note: as briefly mentioned above, the 32-bit value is meant to be a 32-
> bit physical address (64-byte aligned). This address points to a
> predefined struct (i.e., the IPC packet) in shared memory. However,
> since this struct is not HW dependent (it's just the struct the VPU
> firmware expects and in theory it could change if a different VPU FW is
> used), it's not defined here, but in the Keem Bay IPC driver, which is
> the mailbox client for this controller.
>
> The AP is notified of pending messages in the CPU FIFO by means of the
> 'FIFO-not-empty' interrupt, which is generated by the CPU FIFO while not
> empty. This interrupt is cleared automatically once all messages have
> been read from the FIFO (i.e., the FIFO has been emptied).
>
> The hardware doesn't provide an TX done IRQ (i.e., an IRQ that allows
> the VPU firmware to notify the AP that the message put into the VPU FIFO
> has been received); however the AP can ensure that the message has been
> successfully put into the VPU FIFO (and therefore transmitted) by
> checking the VPU FIFO status register (TIM_IPC_FIFO_OF_FLAG0) to ensure
> that writing the message didn't cause the FIFO to overflow (as described
> above).
>
I don't remember the last time I saw such a detailed explanation! Thanks.

> Therefore, the mailbox controller is configured as capable of tx_done
> IRQs and a tasklet is used to simulate the tx_done IRQ. The tasklet is
> activated by send_data() right after the message has been put into the
> VPU FIFO and the VPU FIFO status registers has been checked. If an
> overflow is reported by the status register, the tasklet passes -EBUSY
> to mbox_chan_txdone(), to notify the mailbox client of the failed TX.
>
> The client should therefore register a tx_done() callback to properly
> handle failed transmissions.
>
> Note: the 'txdone_poll' mechanism cannot be used because it doesn't
> provide a way to report a failed transmission.
>
IIUIC, maybe the solution is simpler .... What if we set txdone_poll.
Always return success in send_data(). And check if we overflew the
fifo in last_tx_done(). If we did overflow, try to rewrite the data
and check again. Return true, if not overflew this time, otherwise
return false so that mailbox api can ask us to try again in next
last_tx_done(). This way we can do away with the tasklet and, more
importantly, avoid send_data() failures and retries on clients' part.

Cheers!
