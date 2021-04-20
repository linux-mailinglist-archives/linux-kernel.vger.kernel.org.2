Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235293653DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhDTITo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:19:44 -0400
Received: from cable.insite.cz ([84.242.75.189]:39321 "EHLO cable.insite.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhDTITn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:19:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by cable.insite.cz (Postfix) with ESMTP id 032F1A1A3D403;
        Tue, 20 Apr 2021 10:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
        t=1618906749; bh=U15NHSnYSzJWYk5tW1fi5MHrGuTQr2nbX1gOYURhkq0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cdxIc/UpXjYrpuXBm79JxsXkz9iDLXDOQ/s51i4rQ2B92FhSnwQk99A1aU6Vf1PTL
         ZSse5vjgd0+H4/wx9v2nsm7Dq7/DByvkdFrnl93GsvZu+8P6byxyCjh1TJ3+2sDPl7
         nc5iXDCu7hMkGwk5qVZB+rJqLxuh9shXQ6H8EiKY=
Received: from cable.insite.cz ([84.242.75.189])
        by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qa_zYyIwhfNN; Tue, 20 Apr 2021 10:19:02 +0200 (CEST)
Received: from [192.168.105.22] (ip28.insite.cz [81.0.237.28])
        (Authenticated sender: pavel)
        by cable.insite.cz (Postfix) with ESMTPSA id 114DBA1A3D402;
        Tue, 20 Apr 2021 10:19:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
        t=1618906742; bh=U15NHSnYSzJWYk5tW1fi5MHrGuTQr2nbX1gOYURhkq0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mW03QhIn6QkEIXlxTf1+sHbcHRs1WytamPJvP+vBy52IL2UQcGODzhlbo3U+JCZsW
         p+cmDX6tfl13DWxMvtPS52jLi+7/rmhQ1GrEUQhBjK4cpIwqTlj+OcEM15IvjCQkFo
         CsoVBI0+/y4bd+A2srlcYcW1TQWHVbtpZo/R03oY=
Subject: Re: RPi4 DWC2 gadget doesn't copy data to a buffer in ep0 SETUP +
 DATA OUT transaction
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Linux USB <linux-usb@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAB=otbTVxa=nGWF4K1AYcYyPceYYRkC_1HYSb_Nhu6C9RMZEHA@mail.gmail.com>
 <2e068eea-605c-3f7f-904f-2a1d7279879f@synopsys.com>
 <f0379d74-82fd-949f-f151-6b2a0d7b51ff@ivitera.com>
 <57a43b0c-d82a-8931-5063-ffae488cae1e@synopsys.com>
From:   Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <4a74ad2e-642c-0344-efbf-7b47baab3913@ivitera.com>
Date:   Tue, 20 Apr 2021 10:19:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <57a43b0c-d82a-8931-5063-ffae488cae1e@synopsys.com>
Content-Type: multipart/mixed;
 boundary="------------D28CCD9391A5E77B394EC602"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D28CCD9391A5E77B394EC602
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


Dne 19. 04. 21 v 18:30 Minas Harutyunyan napsal(a):
> Hi Pavel,
> 
> On 4/19/2021 5:22 PM, Pavel Hofman wrote:
>>
>> Dne 11. 02. 21 v 12:21 Minas Harutyunyan napsal(a):
>>> Hi Ruslan,
>>>
>>> On 2/1/2021 3:44 AM, Ruslan Bilovol wrote:
>>>> Hi Minas and other USB experts,
>>>>
>>>> I'm currently developing new features for UAC1/UAC2 audio gadgets
>>>> like Volume/Mute controls which use Control SETUP + DATA OUT
>>>> transactions through ep0.
>>>>
>>>> While it works fine on BeagleBone black board with MUSB UDC,
>>>> on Raspberry Pi 4 with DWC2 UDC there is an issue.
>>>>
>>>> I found that when DWC2 receives ep0 SETUP + DATA OUT transaction,
>>>> it doesn't copy data transferred from the host to EP0 in DATA OUT stage
>>>> to the usb_request->buf buffer. This buffer contains unchanged data from
>>>> previous transactions.
>>>>
>>>
>>> Could you please send debug log with issue and usb trace.
>>>
>>
>> Hi Minas,
>>
>> I confirm this problem with DWC2 gadget on RPi4. I rebased Julian's
>> multiple audio clocks patch
>> https://urldefense.com/v3/__https://lore.kernel.org/patchwork/patch/803422/__;!!A4F2R9G_pg!J3zujH0Tzsp0DBsJm6EPTzG0vdr9plGNx7jmoik8JvN4NqODulvND5RXZiLE8d70RkUod4ZZ$  on top of Ruslan's
>> implicit feedback patches
>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-usb/list/?series=&submitter=121671&state=&q=&archive=&delegate=__;!!A4F2R9G_pg!J3zujH0Tzsp0DBsJm6EPTzG0vdr9plGNx7jmoik8JvN4NqODulvND5RXZiLE8d70Rtv_duVh$
>> on branch rpi-5.12.y
>> https://urldefense.com/v3/__https://github.com/raspberrypi/linux/tree/rpi-5.12.y__;!!A4F2R9G_pg!J3zujH0Tzsp0DBsJm6EPTzG0vdr9plGNx7jmoik8JvN4NqODulvND5RXZiLE8d70Rkqjb2Qb$  and compiled for arm64.
>>
>> When USB host switches audio playback to non-default samplerate (from
>> 96000 to 192000 in my case), usb_request->buf contains the previous
>> default value of 96000, instead of the new value sent by the host - see
>> the captured USB packet below:
>>
>> ===============
>> Frame 9: 68 bytes on wire (544 bits), 68 bytes captured (544 bits) on
>> interface usbmon1, id 0
>>      Interface id: 0 (usbmon1)
>>          Interface name: usbmon1
>>      Encapsulation type: USB packets with Linux header and padding (115)
>>      Arrival Time: Apr 19, 2021 13:41:25.146650000 CEST
>>      [Time shift for this packet: 0.000000000 seconds]
>>      Epoch Time: 1618832485.146650000 seconds
>>      [Time delta from previous captured frame: 0.000050000 seconds]
>>      [Time delta from previous displayed frame: 0.000050000 seconds]
>>      [Time since reference or first frame: 6.013518000 seconds]
>>      Frame Number: 9
>>      Frame Length: 68 bytes (544 bits)
>>      Capture Length: 68 bytes (544 bits)
>>      [Frame is marked: False]
>>      [Frame is ignored: False]
>>      [Protocols in frame: usb]
>> USB URB
>>      [Source: host]
>>      [Destination: 1.14.0]
>>      URB id: 0xffff8c37444f2480
>>      URB type: URB_SUBMIT ('S')
>>      URB transfer type: URB_CONTROL (0x02)
>>      Endpoint: 0x00, Direction: OUT
>>          0... .... = Direction: OUT (0)
>>          .... 0000 = Endpoint number: 0
>>      Device: 14
>>      URB bus id: 1
>>      Device setup request: relevant (0)
>>      Data: present (0)
>>      URB sec: 1618832485
>>      URB usec: 146650
>>      URB status: Operation now in progress (-EINPROGRESS) (-115)
>>      URB length [bytes]: 4
>>      Data length [bytes]: 4
>>      [Response in: 10]
>>      Interval: 0
>>      Start frame: 0
>>      Copy of Transfer Flags: 0x00000000
>>          .... .... .... .... .... .... .... ...0 = Short not OK: False
>>          .... .... .... .... .... .... .... ..0. = ISO ASAP: False
>>          .... .... .... .... .... .... .... .0.. = No transfer DMA map: False
>>          .... .... .... .... .... .... ..0. .... = No FSBR: False
>>          .... .... .... .... .... .... .0.. .... = Zero Packet: False
>>          .... .... .... .... .... .... 0... .... = No Interrupt: False
>>          .... .... .... .... .... ...0 .... .... = Free Buffer: False
>>          .... .... .... .... .... ..0. .... .... = Dir IN: False
>>          .... .... .... ...0 .... .... .... .... = DMA Map Single: False
>>          .... .... .... ..0. .... .... .... .... = DMA Map Page: False
>>          .... .... .... .0.. .... .... .... .... = DMA Map SG: False
>>          .... .... .... 0... .... .... .... .... = Map Local: False
>>          .... .... ...0 .... .... .... .... .... = Setup Map Single: False
>>          .... .... ..0. .... .... .... .... .... = Setup Map Local: False
>>          .... .... .0.. .... .... .... .... .... = DMA S-G Combined: False
>>          .... .... 0... .... .... .... .... .... = Aligned Temp Buffer: False
>>      Number of ISO descriptors: 0
>>      [bInterfaceClass: Unknown (0xffff)]
>> Setup Data
>>      bmRequestType: 0x21
>>          0... .... = Direction: Host-to-device
>>          .01. .... = Type: Class (0x1)
>>          ...0 0001 = Recipient: Interface (0x01)
>>      bRequest: 1
>>      wValue: 0x0100
>>      wIndex: 1792 (0x0700)
>>      wLength: 4
>>      Data Fragment: 00ee0200      <------------------------------
>> ===============
>>
>>
Hi Minas,


> Some clarifications required:
> 1. gadget works in scatter/gather DMA mode (g_dma_desc is true)?

I guess not, this is /sys/kernel/debug/usb/fe980000.usb/params:

otg_cap                       : 0
dma_desc_enable               : 0
dma_desc_fs_enable            : 0
speed                         : 0
enable_dynamic_fifo           : 1
en_multiple_tx_fifo           : 1
host_rx_fifo_size             : 774
host_nperio_tx_fifo_size      : 256
host_perio_tx_fifo_size       : 512
max_transfer_size             : 65535
max_packet_count              : 511
host_channels                 : 8
phy_type                      : 1
phy_utmi_width                : 8
phy_ulpi_ddr                  : 0
phy_ulpi_ext_vbus             : 0
i2c_enable                    : 0
ipg_isoc_en                   : 0
ulpi_fs_ls                    : 0
host_support_fs_ls_low_power  : 0
host_ls_low_power_phy_clk     : 0
ts_dline                      : 0
reload_ctl                    : 0
ahbcfg                        : 0x10
uframe_sched                  : 1
external_id_pin_ctl           : 0
power_down                    : 0
lpm                           : 0
lpm_clock_gating              : 0
besl                          : 0
hird_threshold_en             : 0
hird_threshold                : 0
service_interval              : 0
host_dma                      : 1
g_dma                         : 1
g_dma_desc                    : 0
g_rx_fifo_size                : 558
g_np_tx_fifo_size             : 32
g_tx_fifo_size[0]             : 0
g_tx_fifo_size[1]             : 512
g_tx_fifo_size[2]             : 512
g_tx_fifo_size[3]             : 512
g_tx_fifo_size[4]             : 512
g_tx_fifo_size[5]             : 512
g_tx_fifo_size[6]             : 256
g_tx_fifo_size[7]             : 256
g_tx_fifo_size[8]             : 0
g_tx_fifo_size[9]             : 0
g_tx_fifo_size[10]            : 0
g_tx_fifo_size[11]            : 0
g_tx_fifo_size[12]            : 0
g_tx_fifo_size[13]            : 0
g_tx_fifo_size[14]            : 0
g_tx_fifo_size[15]            : 0



Also /sys/kernel/debug/usb/fe980000.usb/regdump attached.


> 2. Above captured Host side USB packet corresponds in dmesg to line#39907:
> 
> [ 1261.789552] dwc2 fe980000.usb: ctrl Type=21, Req=01, V=0100, I=0700, 
> L=0004
> 
> Correct?


I think more likely from line #2319 - the value 96000 should be 192000
instead.

[ 1260.277683] dwc2 fe980000.usb: dwc2_hsotg_start_req:
DxEPCTL=0x00028000, ep 0, dir out
[ 1260.277690] dwc2 fe980000.usb: ureq->length:8 ureq->actual:0
[ 1260.277696] dwc2 fe980000.usb: dwc2_hsotg_start_req: 1@8/8,
0x00080008 => 0x00000b10
[ 1260.277702] dwc2 fe980000.usb: dwc2_hsotg_start_req:
0x00000000fb0ca000 => 0x00000b14
[ 1260.277707] dwc2 fe980000.usb: ep0 state:0
[ 1260.277711] dwc2 fe980000.usb: dwc2_hsotg_start_req: DxEPCTL=0x80028000
[ 1260.277718] dwc2 fe980000.usb: dwc2_hsotg_start_req: DXEPCTL=0x80028000
[ 1260.277806] dwc2 fe980000.usb: dwc2_hsotg_irq: 040c8028 000c0000
(d0bc3cc4) retry 8
[ 1260.277813] dwc2 fe980000.usb: dwc2_hsotg_irq: daint=00010001
[ 1260.277818] dwc2 fe980000.usb: dwc2_hsotg_epint: ep0(out)
DxEPINT=0x00000008
[ 1260.277823] dwc2 fe980000.usb: dwc2_hsotg_epint: Setup/Timeout
[ 1260.277831] dwc2 fe980000.usb: complete: ep 0000000018e5b31a ep0, req
00000000432c9718, 0 => 000000002d523fc0
[ 1260.277839] dwc2 fe980000.usb: ctrl Type=a1, Req=01, V=0100, I=0700,
L=0004
[ 1260.277846] g_audio gadget: ac_rq_in(): 1
[ 1260.277850] g_audio gadget: in_rq_cur(): 96000
[ 1260.277857] dwc2 fe980000.usb: ep0: req 00000000cf0a7502:
4@000000000e574c90, noi=0, zero=0, snok=0
[ 1260.277865] dwc2 fe980000.usb: dwc2_hsotg_start_req:
DxEPCTL=0x00028000, ep 0, dir in
[ 1260.277870] dwc2 fe980000.usb: ureq->length:4 ureq->actual:0
[ 1260.277886] dwc2 fe980000.usb: ep0 state:1
[ 1260.277913] dwc2 fe980000.usb: req->length:4 req->actual:4 req->zero:0
[ 1260.277944] dwc2 fe980000.usb: zlp packet received
[ 1260.277948] dwc2 fe980000.usb: complete: ep 0000000018e5b31a ep0, req
00000000cf0a7502, 0 => 0000000023e79ed8
[ 1260.277984] dwc2 fe980000.usb: ureq->length:8 ureq->actual:0
[ 1260.278078] dwc2 fe980000.usb: dwc2_hsotg_epint: ep0(out)
DxEPINT=0x00000018
[ 1260.278104] dwc2 fe980000.usb: ep0: req 00000000cf0a7502:
4@000000000e574c90, noi=0, zero=0, snok=0
[ 1260.278128] dwc2 fe980000.usb: dwc2_hsotg_start_req:
0x00000000fb0cb800 => 0x00000b14
[ 1260.278163] dwc2 fe980000.usb: dwc2_hsotg_epint: XferCompl:
DxEPCTL=0x00028000, DXEPTSIZ=00000000
[ 1260.278182] g_audio gadget: Calling uac2_cs_control_sam_freq 2.
[ 1260.278186] g_audio gadget: uac2_cs_control_sam_freq val: 96000.
[ 1260.278190] g_audio gadget: Calling uac2_cs_control_sam_freq OUT.

> 
> 3. You assume that issue seen in below printk's (lines##39923-39927):

Maybe this part later in the dmesg dump is switching back to the default
96000 after playback stops, I am sorry for my lack of USB protocol
knowledge.

But lines starting at #2319 correspond to the SETUP packet with 192000
value.
> 
> [ 1261.789640] g_audio gadget: Calling uac2_cs_control_sam_freq 1.
> [ 1261.789652] g_audio gadget: Calling uac2_cs_control_sam_freq 2.
> [ 1261.789655] g_audio gadget: uac2_cs_control_sam_freq val: 96000.
> [ 1261.789659] g_audio gadget: Calling uac2_cs_control_sam_freq OUT.
> [ 1261.789665] Calling u_audio_set_capture_srate with srate 96000
> 
> Instead both 96000 should be 192000? Could you please provide me 
> messages sequence for correct behaviour for 192000.

I am afraid I do not know how to do that. The host sends 192000 but the
gadget function receives 96000. When stopping playback and starting at
96000, again 96000 is received. When going back to 192000, again 96000
is received.

> 
> 4. Below dmesg fragment not corresponds to observed issue, it's just for 
> show added printk's in g_audio. Correct?

It's the same sequence I listed in point 1 of this message. It shows the
observed issue.

My wireshark packet was captured in an earlier run, therefore some
possible packet IDs (if any exist) would not fit with the dump. But it
is the same observed situation - the packet carries 192000, yet f_uac2
->u_audio receive 96000.

I pushed my current source code with all the rebased patches to
https://github.com/pavhofman/linux-rpi/tree/fb5afcec549a998cafe9e0d11534400f508d8be3
for reference.

The function receiving incorrect value is
https://github.com/pavhofman/linux-rpi/blob/fb5afcec549a998cafe9e0d11534400f508d8be3/drivers/usb/gadget/function/f_uac2.c#L1476
, registered in req->complete callback in
https://github.com/pavhofman/linux-rpi/blob/fb5afcec549a998cafe9e0d11534400f508d8be3/drivers/usb/gadget/function/f_uac2.c#L1573

Thanks a lot!

Pavel.

> 
> Thanks,
> Minas
> 
> 
>> The value sent 00ee0200 corresponds to 192000, but the gadget received
>> the original 96000 (I added some printks to g_audio):
>>
>> ==========
>> [ 1260.277857] dwc2 fe980000.usb: ep0: req 00000000cf0a7502:
>> 4@000000000e574c90, noi=0, zero=0, snok=0
>> [ 1260.277865] dwc2 fe980000.usb: dwc2_hsotg_start_req:
>> DxEPCTL=0x00028000, ep 0, dir in
>> [ 1260.277870] dwc2 fe980000.usb: ureq->length:4 ureq->actual:0
>> [ 1260.277886] dwc2 fe980000.usb: ep0 state:1
>> [ 1260.277913] dwc2 fe980000.usb: req->length:4 req->actual:4 req->zero:0
>> [ 1260.277944] dwc2 fe980000.usb: zlp packet received
>> [ 1260.277948] dwc2 fe980000.usb: complete: ep 0000000018e5b31a ep0, req
>> 00000000cf0a7502, 0 => 0000000023e79ed8
>> [ 1260.277984] dwc2 fe980000.usb: ureq->length:8 ureq->actual:0
>> [ 1260.278078] dwc2 fe980000.usb: dwc2_hsotg_epint: ep0(out)
>> DxEPINT=0x00000018
>> [ 1260.278104] dwc2 fe980000.usb: ep0: req 00000000cf0a7502:
>> 4@000000000e574c90, noi=0, zero=0, snok=0
>> [ 1260.278128] dwc2 fe980000.usb: dwc2_hsotg_start_req:
>> 0x00000000fb0cb800 => 0x00000b14
>> [ 1260.278163] dwc2 fe980000.usb: dwc2_hsotg_epint: XferCompl:
>> DxEPCTL=0x00028000, DXEPTSIZ=00000000
>> [ 1260.278182] g_audio gadget: Calling uac2_cs_control_sam_freq 2.
>> [ 1260.278186] g_audio gadget: uac2_cs_control_sam_freq val: 96000.
>> ============
>>

--------------D28CCD9391A5E77B394EC602
Content-Type: text/plain; charset=UTF-8;
 name="regdump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="regdump"

R09UR0NUTCA9IDB4MDAwZDAwMDAKR09UR0lOVCA9IDB4MDAwMDAwMDAKR0FIQkNGRyA9IDB4
MDAwMDAwMzEKR1VTQkNGRyA9IDB4MDAwMDE0MDAKR1JTVENUTCA9IDB4ODAwMDAxYzAKR0lO
VFNUUyA9IDB4MDQwMDgwMmEKR0lOVE1TSyA9IDB4ZDBiYzNjNDQKR1JYU1RTUiA9IDB4NjMx
MWE3ZDMKR1JYRlNJWiA9IDB4MDAwMDAyMmUKR05QVFhGU0laID0gMHgwMDIwMDIyZQpHTlBU
WFNUUyA9IDB4MDAwODAwMjAKR0kyQ0NUTCA9IDB4MDAwMDAwMDAKR1BWTkRDVEwgPSAweDAw
MDAwMDAwCkdHUElPID0gMHgwMDAwMDAwMApHVUlEID0gMHgyNzA4YTAwMApHU05QU0lEID0g
MHg0ZjU0MjgwYQpHSFdDRkcxID0gMHgwMDAwMDAwMApHSFdDRkcyID0gMHgyMjhkZGQ1MApH
SFdDRkczID0gMHgwZmYwMDBlOApHSFdDRkc0ID0gMHgxZmYwMDAyMApHTFBNQ0ZHID0gMHg3
NTczNjIzMApHUFdSRE4gPSAweDAwMDAwMDAwCkdERklGT0NGRyA9IDB4MDAwMDAwMDAKQURQ
Q1RMID0gMHgwMDAwMDAwMApIUFRYRlNJWiA9IDB4MDEwMDBkNGUKRFBUWEZTSVpOKDEpID0g
MHgwMjAwMDI0ZQpEUFRYRlNJWk4oMikgPSAweDAyMDAwNDRlCkRQVFhGU0laTigzKSA9IDB4
MDIwMDA2NGUKRFBUWEZTSVpOKDQpID0gMHgwMjAwMDg0ZQpEUFRYRlNJWk4oNSkgPSAweDAy
MDAwYTRlCkRQVFhGU0laTig2KSA9IDB4MDEwMDBjNGUKRFBUWEZTSVpOKDcpID0gMHgwMTAw
MGQ0ZQpEUFRYRlNJWk4oOCkgPSAweDAxMDAwZDRlCkRQVFhGU0laTig5KSA9IDB4MDIwMDAy
NGUKRFBUWEZTSVpOKDEwKSA9IDB4MDIwMDA0NGUKRFBUWEZTSVpOKDExKSA9IDB4MDIwMDA2
NGUKRFBUWEZTSVpOKDEyKSA9IDB4MDIwMDA4NGUKRFBUWEZTSVpOKDEzKSA9IDB4MDIwMDBh
NGUKRFBUWEZTSVpOKDE0KSA9IDB4MDEwMDBjNGUKRFBUWEZTSVpOKDE1KSA9IDB4MDEwMDBk
NGUKRENGRyA9IDB4MDAwNDAwMjAKRENUTCA9IDB4MDAwMDAwMDAKRFNUUyA9IDB4MDAwMWJm
MDIKRElFUE1TSyA9IDB4MDAwMDIwMGYKRE9FUE1TSyA9IDB4MDAwMDAwMGYKREFJTlQgPSAw
eDAwMDAwMDAwCkRBSU5UTVNLID0gMHgwMDAxMDAwMwpEVEtOUVIxID0gMHgwMDAwMDAwMApE
VEtOUVIyID0gMHgwMDAwMDAwMApEVEtOUVIzID0gMHgwYzEwMDAyMApEVEtOUVI0ID0gMHgw
MDAwMDAwMApEVkJVU0RJUyA9IDB4MDAwMDE3ZDcKRFZCVVNQVUxTRSA9IDB4MDAwMDA1YjgK
RElFUENUTCgwKSA9IDB4MDAwMDgwMDAKRElFUENUTCgxKSA9IDB4MDE4YzgwMDYKRElFUENU
TCgyKSA9IDB4MDFjNjAwMDMKRElFUENUTCgzKSA9IDB4MDA0NjAzZmYKRElFUENUTCg0KSA9
IDB4MDAwMDAzZmYKRElFUENUTCg1KSA9IDB4MDAwMDAzZmYKRElFUENUTCg2KSA9IDB4MDAw
MDAzZmYKRElFUENUTCg3KSA9IDB4MDAwMDAzZmYKRElFUENUTCg4KSA9IDB4MDAwMDAzZmYK
RElFUENUTCg5KSA9IDB4MDAwMDAzZmYKRElFUENUTCgxMCkgPSAweDAwMDAwM2ZmCkRJRVBD
VEwoMTEpID0gMHgwMDAwMDNmZgpESUVQQ1RMKDEyKSA9IDB4MDAwMDAzZmYKRElFUENUTCgx
MykgPSAweDAwMDAwM2ZmCkRJRVBDVEwoMTQpID0gMHgwMDAwMDNmZgpESUVQQ1RMKDE1KSA9
IDB4MDAwMDAzZmYKRE9FUENUTCgwKSA9IDB4ODAwMjgwMDAKRE9FUENUTCgxKSA9IDB4MDAw
NzAzZmYKRE9FUENUTCgyKSA9IDB4MDAwMDAzZmYKRE9FUENUTCgzKSA9IDB4MDAwMDAzZmYK
RE9FUENUTCg0KSA9IDB4MDAwMDAzZmYKRE9FUENUTCg1KSA9IDB4MDAwMDAzZmYKRE9FUENU
TCg2KSA9IDB4MDAwMDAzZmYKRE9FUENUTCg3KSA9IDB4MDAwMDAzZmYKRE9FUENUTCg4KSA9
IDB4MDAwMDAzZmYKRE9FUENUTCg5KSA9IDB4MDAwMDAzZmYKRE9FUENUTCgxMCkgPSAweDAw
MDAwM2ZmCkRPRVBDVEwoMTEpID0gMHgwMDAwMDNmZgpET0VQQ1RMKDEyKSA9IDB4MDAwMDAz
ZmYKRE9FUENUTCgxMykgPSAweDAwMDAwM2ZmCkRPRVBDVEwoMTQpID0gMHgwMDAwMDNmZgpE
T0VQQ1RMKDE1KSA9IDB4MDAwMDAzZmYKRElFUElOVCgwKSA9IDB4MDAwMDAwZDAKRElFUElO
VCgxKSA9IDB4MDAwMDAwMTAKRElFUElOVCgyKSA9IDB4MDAwMDAwMDAKRElFUElOVCgzKSA9
IDB4MDAwMDAwODAKRElFUElOVCg0KSA9IDB4MDAwMDAwODAKRElFUElOVCg1KSA9IDB4MDAw
MDAwODAKRElFUElOVCg2KSA9IDB4MDAwMDAwODAKRElFUElOVCg3KSA9IDB4MDAwMDAwODAK
RElFUElOVCg4KSA9IDB4MDAwMDAwODAKRElFUElOVCg5KSA9IDB4MDAwMDAwODAKRElFUElO
VCgxMCkgPSAweDAwMDAwMDgwCkRJRVBJTlQoMTEpID0gMHgwMDAwMDA4MApESUVQSU5UKDEy
KSA9IDB4MDAwMDAwODAKRElFUElOVCgxMykgPSAweDAwMDAwMDgwCkRJRVBJTlQoMTQpID0g
MHgwMDAwMDA4MApESUVQSU5UKDE1KSA9IDB4MDAwMDAwODAKRE9FUElOVCgwKSA9IDB4MDAw
MDIwMDAKRE9FUElOVCgxKSA9IDB4MDAwMDAwMDAKRE9FUElOVCgyKSA9IDB4MDAwMDAwMDAK
RE9FUElOVCgzKSA9IDB4MDAwMDAwMDAKRE9FUElOVCg0KSA9IDB4MDAwMDAwMDAKRE9FUElO
VCg1KSA9IDB4MDAwMDAwMDAKRE9FUElOVCg2KSA9IDB4MDAwMDAwMDAKRE9FUElOVCg3KSA9
IDB4MDAwMDAwMDAKRE9FUElOVCg4KSA9IDB4MDAwMDAwMDAKRE9FUElOVCg5KSA9IDB4MDAw
MDAwMDAKRE9FUElOVCgxMCkgPSAweDAwMDAwMDAwCkRPRVBJTlQoMTEpID0gMHgwMDAwMDAw
MApET0VQSU5UKDEyKSA9IDB4MDAwMDAwMDAKRE9FUElOVCgxMykgPSAweDAwMDAwMDAwCkRP
RVBJTlQoMTQpID0gMHgwMDAwMDAwMApET0VQSU5UKDE1KSA9IDB4MDAwMDAwMDAKRElFUFRT
SVooMCkgPSAweDAwMDAwMDAwCkRJRVBUU0laKDEpID0gMHgwMDAwMDAwMApESUVQVFNJWigy
KSA9IDB4MjAwODAwMDAKRElFUFRTSVooMykgPSAweDAwMDAwMDAwCkRJRVBUU0laKDQpID0g
MHgwMDAwMDAwMApESUVQVFNJWig1KSA9IDB4MDAwMDAwMDAKRElFUFRTSVooNikgPSAweDAw
MDAwMDAwCkRJRVBUU0laKDcpID0gMHgwMDAwMDAwMApESUVQVFNJWig4KSA9IDB4MDAwMDAw
MDAKRElFUFRTSVooOSkgPSAweDAwMDAwMDAwCkRJRVBUU0laKDEwKSA9IDB4MDAwMDAwMDAK
RElFUFRTSVooMTEpID0gMHgwMDAwMDAwMApESUVQVFNJWigxMikgPSAweDAwMDAwMDAwCkRJ
RVBUU0laKDEzKSA9IDB4MDAwMDAwMDAKRElFUFRTSVooMTQpID0gMHgwMDAwMDAwMApESUVQ
VFNJWigxNSkgPSAweDAwMDAwMDAwCkRPRVBUU0laKDApID0gMHgwMDA4MDAwOApET0VQVFNJ
WigxKSA9IDB4MDAwODAzZmYKRE9FUFRTSVooMikgPSAweDAwMDAwMDAwCkRPRVBUU0laKDMp
ID0gMHgwMDAwMDAwMApET0VQVFNJWig0KSA9IDB4MDAwMDAwMDAKRE9FUFRTSVooNSkgPSAw
eDAwMDAwMDAwCkRPRVBUU0laKDYpID0gMHgwMDAwMDAwMApET0VQVFNJWig3KSA9IDB4MDAw
MDAwMDAKRE9FUFRTSVooOCkgPSAweDAwMDAwMDAwCkRPRVBUU0laKDkpID0gMHgwMDAwMDAw
MApET0VQVFNJWigxMCkgPSAweDAwMDAwMDAwCkRPRVBUU0laKDExKSA9IDB4MDAwMDAwMDAK
RE9FUFRTSVooMTIpID0gMHgwMDAwMDAwMApET0VQVFNJWigxMykgPSAweDAwMDAwMDAwCkRP
RVBUU0laKDE0KSA9IDB4MDAwMDAwMDAKRE9FUFRTSVooMTUpID0gMHgwMDAwMDAwMApESUVQ
RE1BKDApID0gMHhmYjIyNzgwNApESUVQRE1BKDEpID0gMHhjZjhhMDI4NQpESUVQRE1BKDIp
ID0gMHhmODVjZTgwNApESUVQRE1BKDMpID0gMHg2MjMxZTFhOQpESUVQRE1BKDQpID0gMHg1
OGFiNmU5NApESUVQRE1BKDUpID0gMHhlZDcwMmUxZApESUVQRE1BKDYpID0gMHhkYmMxNmE5
NApESUVQRE1BKDcpID0gMHgyZWU5OTkyYwpESUVQRE1BKDgpID0gMHgyNTY4ODIxMQpESUVQ
RE1BKDkpID0gMHgyNTY4ODIxMQpESUVQRE1BKDEwKSA9IDB4MjU2ODgyMTEKRElFUERNQSgx
MSkgPSAweDI1Njg4MjExCkRJRVBETUEoMTIpID0gMHgyNTY4ODIxMQpESUVQRE1BKDEzKSA9
IDB4MjU2ODgyMTEKRElFUERNQSgxNCkgPSAweDI1Njg4MjExCkRJRVBETUEoMTUpID0gMHgy
NTY4ODIxMQpET0VQRE1BKDApID0gMHhmODVjZjAwMApET0VQRE1BKDEpID0gMHhmODVjNjAw
MApET0VQRE1BKDIpID0gMHhlNjZjMWY4YwpET0VQRE1BKDMpID0gMHgwYTI2NDM0NQpET0VQ
RE1BKDQpID0gMHg2ZmVlMDdiZApET0VQRE1BKDUpID0gMHg3MjE1MzgwZgpET0VQRE1BKDYp
ID0gMHg2MzExYTdkMwpET0VQRE1BKDcpID0gMHgyNTY4ODIxMQpET0VQRE1BKDgpID0gMHgw
MDAwMDAwMApET0VQRE1BKDkpID0gMHgwMDAwMDAwMApET0VQRE1BKDEwKSA9IDB4MDAwMDAw
MDAKRE9FUERNQSgxMSkgPSAweDAwMDAwMDAwCkRPRVBETUEoMTIpID0gMHgwMDAwMDAwMApE
T0VQRE1BKDEzKSA9IDB4MDAwMDAwMDAKRE9FUERNQSgxNCkgPSAweDAwMDAwMDAwCkRPRVBE
TUEoMTUpID0gMHgwMDAwMDAwMApEVFhGU1RTKDApID0gMHgwMDAwMDAyMApEVFhGU1RTKDEp
ID0gMHgwMDAwMDEwMApEVFhGU1RTKDIpID0gMHgwMDAwMDEwMApEVFhGU1RTKDMpID0gMHgw
MDAwMDIwMApEVFhGU1RTKDQpID0gMHgwMDAwMDAyMApEVFhGU1RTKDUpID0gMHgwMDAwMDAy
MApEVFhGU1RTKDYpID0gMHgwMDAwMDAyMApEVFhGU1RTKDcpID0gMHgwMDAwMDAyMApEVFhG
U1RTKDgpID0gMHgwMDAwMDAyMApEVFhGU1RTKDkpID0gMHgwMDAwMDAyMApEVFhGU1RTKDEw
KSA9IDB4MDAwMDAwMjAKRFRYRlNUUygxMSkgPSAweDAwMDAwMDIwCkRUWEZTVFMoMTIpID0g
MHgwMDAwMDAyMApEVFhGU1RTKDEzKSA9IDB4MDAwMDAwMjAKRFRYRlNUUygxNCkgPSAweDAw
MDAwMDIwCkRUWEZTVFMoMTUpID0gMHgwMDAwMDAyMApQQ0dDVEwgPSAweDAwMDAwMDAwCkhD
RkcgPSAweDAwMDQwMDIwCkhGSVIgPSAweDAwMDAxN2Q3CkhGTlVNID0gMHg2ZDU0MDFiZgpI
UFRYU1RTID0gMHgwMDA4MDIwMApIQUlOVCA9IDB4MDAwMDAwMDAKSEFJTlRNU0sgPSAweDAw
MDAwMDAzCkhGTEJBRERSID0gMHgwMDAwMDAwMApIUFJUMCA9IDB4MDAwMDA0MDAKSENDSEFS
KDApID0gMHgwMThjODAwNgpIQ0NIQVIoMSkgPSAweDAwMDcwM2ZmCkhDQ0hBUigyKSA9IDB4
MDAwMDAzZmYKSENDSEFSKDMpID0gMHgwMDAwMDNmZgpIQ0NIQVIoNCkgPSAweDAwMDAwM2Zm
CkhDQ0hBUig1KSA9IDB4MDAwMDAzZmYKSENDSEFSKDYpID0gMHgwMDAwMDNmZgpIQ0NIQVIo
NykgPSAweDAwMDAwM2ZmCkhDQ0hBUig4KSA9IDB4MDAwMDAzZmYKSENDSEFSKDkpID0gMHgw
MDAwMDNmZgpIQ0NIQVIoMTApID0gMHgwMDAwMDNmZgpIQ0NIQVIoMTEpID0gMHgwMDAwMDNm
ZgpIQ0NIQVIoMTIpID0gMHgwMDAwMDNmZgpIQ0NIQVIoMTMpID0gMHgwMDAwMDNmZgpIQ0NI
QVIoMTQpID0gMHgwMDAwMDNmZgpIQ0NIQVIoMTUpID0gMHgwMDAwMDNmZgpIQ1NQTFQoMCkg
PSAweDAwMDAwMDAwCkhDU1BMVCgxKSA9IDB4MDAwMDAwMDAKSENTUExUKDIpID0gMHgwMDAw
MDAwMApIQ1NQTFQoMykgPSAweDAwMDAwMDAwCkhDU1BMVCg0KSA9IDB4MDAwMDAwMDAKSENT
UExUKDUpID0gMHgwMDAwMDAwMApIQ1NQTFQoNikgPSAweDAwMDAwMDAwCkhDU1BMVCg3KSA9
IDB4MDAwMDAwMDAKSENTUExUKDgpID0gMHgwMDAwMDAwMApIQ1NQTFQoOSkgPSAweDAwMDAw
MDAwCkhDU1BMVCgxMCkgPSAweDAwMDAwMDAwCkhDU1BMVCgxMSkgPSAweDAwMDAwMDAwCkhD
U1BMVCgxMikgPSAweDAwMDAwMDAwCkhDU1BMVCgxMykgPSAweDAwMDAwMDAwCkhDU1BMVCgx
NCkgPSAweDAwMDAwMDAwCkhDU1BMVCgxNSkgPSAweDAwMDAwMDAwCkhDSU5UKDApID0gMHgw
MDAwMDAxMApIQ0lOVCgxKSA9IDB4MDAwMDAwMDAKSENJTlQoMikgPSAweDAwMDAwMDAwCkhD
SU5UKDMpID0gMHgwMDAwMDAwMApIQ0lOVCg0KSA9IDB4MDAwMDAwMDAKSENJTlQoNSkgPSAw
eDAwMDAwMDAwCkhDSU5UKDYpID0gMHgwMDAwMDAwMApIQ0lOVCg3KSA9IDB4MDAwMDAwMDAK
SENJTlQoOCkgPSAweDAwMDAwMDAwCkhDSU5UKDkpID0gMHgwMDAwMDAwMApIQ0lOVCgxMCkg
PSAweDAwMDAwMDAwCkhDSU5UKDExKSA9IDB4MDAwMDAwMDAKSENJTlQoMTIpID0gMHgwMDAw
MDAwMApIQ0lOVCgxMykgPSAweDAwMDAwMDAwCkhDSU5UKDE0KSA9IDB4MDAwMDAwMDAKSENJ
TlQoMTUpID0gMHgwMDAwMDAwMApIQ0lOVE1TSygwKSA9IDB4MDAwMDAwMGYKSENJTlRNU0so
MSkgPSAweDAwMDAwMDAwCkhDSU5UTVNLKDIpID0gMHgwMDAwMDAwMApIQ0lOVE1TSygzKSA9
IDB4MDAwMDAwMDAKSENJTlRNU0soNCkgPSAweDAwMDAwMDAwCkhDSU5UTVNLKDUpID0gMHgw
MDAwMDAwMApIQ0lOVE1TSyg2KSA9IDB4MDAwMDAwMDAKSENJTlRNU0soNykgPSAweDAwMDAw
MDAwCkhDSU5UTVNLKDgpID0gMHgwMDAwMDAwMApIQ0lOVE1TSyg5KSA9IDB4MDAwMDAwMDAK
SENJTlRNU0soMTApID0gMHgwMDAwMDAwMApIQ0lOVE1TSygxMSkgPSAweDAwMDAwMDAwCkhD
SU5UTVNLKDEyKSA9IDB4MDAwMDAwMDAKSENJTlRNU0soMTMpID0gMHgwMDAwMDAwMApIQ0lO
VE1TSygxNCkgPSAweDAwMDAwMDAwCkhDSU5UTVNLKDE1KSA9IDB4MDAwMDAwMDAKSENUU0la
KDApID0gMHgwMDAwMDAwMApIQ1RTSVooMSkgPSAweDAwMDgwM2ZmCkhDVFNJWigyKSA9IDB4
MDAwMDAwMDAKSENUU0laKDMpID0gMHgwMDAwMDAwMApIQ1RTSVooNCkgPSAweDAwMDAwMDAw
CkhDVFNJWig1KSA9IDB4MDAwMDAwMDAKSENUU0laKDYpID0gMHgwMDAwMDAwMApIQ1RTSVoo
NykgPSAweDAwMDAwMDAwCkhDVFNJWig4KSA9IDB4MDAwMDAwMDAKSENUU0laKDkpID0gMHgw
MDAwMDAwMApIQ1RTSVooMTApID0gMHgwMDAwMDAwMApIQ1RTSVooMTEpID0gMHgwMDAwMDAw
MApIQ1RTSVooMTIpID0gMHgwMDAwMDAwMApIQ1RTSVooMTMpID0gMHgwMDAwMDAwMApIQ1RT
SVooMTQpID0gMHgwMDAwMDAwMApIQ1RTSVooMTUpID0gMHgwMDAwMDAwMApIQ0RNQSgwKSA9
IDB4Zjg1Y2YwMDAKSENETUEoMSkgPSAweGY4NWM2MDAwCkhDRE1BKDIpID0gMHhlNjZjMWY4
YwpIQ0RNQSgzKSA9IDB4MGEyNjQzNDUKSENETUEoNCkgPSAweDZmZWUwN2JkCkhDRE1BKDUp
ID0gMHg3MjE1MzgwZgpIQ0RNQSg2KSA9IDB4NjMxMWE3ZDMKSENETUEoNykgPSAweDI1Njg4
MjExCkhDRE1BKDgpID0gMHgwMDAwMDAwMApIQ0RNQSg5KSA9IDB4MDAwMDAwMDAKSENETUEo
MTApID0gMHgwMDAwMDAwMApIQ0RNQSgxMSkgPSAweDAwMDAwMDAwCkhDRE1BKDEyKSA9IDB4
MDAwMDAwMDAKSENETUEoMTMpID0gMHgwMDAwMDAwMApIQ0RNQSgxNCkgPSAweDAwMDAwMDAw
CkhDRE1BKDE1KSA9IDB4MDAwMDAwMDAKSENETUFCKDApID0gMHgwMDAwMDAwMApIQ0RNQUIo
MSkgPSAweGY4NWNmMDAwCkhDRE1BQigyKSA9IDB4Zjg1YzYwMDAKSENETUFCKDMpID0gMHhl
NjZjMWY4YwpIQ0RNQUIoNCkgPSAweDBhMjY0MzQ1CkhDRE1BQig1KSA9IDB4NmZlZTA3YmQK
SENETUFCKDYpID0gMHg3MjE1MzgwZgpIQ0RNQUIoNykgPSAweDYzMTFhN2QzCkhDRE1BQig4
KSA9IDB4MjU2ODgyMTEKSENETUFCKDkpID0gMHgwMDAwMDAwMApIQ0RNQUIoMTApID0gMHgw
MDAwMDAwMApIQ0RNQUIoMTEpID0gMHgwMDAwMDAwMApIQ0RNQUIoMTIpID0gMHgwMDAwMDAw
MApIQ0RNQUIoMTMpID0gMHgwMDAwMDAwMApIQ0RNQUIoMTQpID0gMHgwMDAwMDAwMApIQ0RN
QUIoMTUpID0gMHgwMDAwMDAwMAo=
--------------D28CCD9391A5E77B394EC602--
