Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A943262FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhBZMyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:54:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:33022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZMyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:54:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1E6CAE03;
        Fri, 26 Feb 2021 12:54:00 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To:     Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
 <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
Date:   Fri, 26 Feb 2021 13:54:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/21 1:35 PM, Daniel Wagner wrote:
> On Mon, Feb 15, 2021 at 01:29:45PM -0800, Sagi Grimberg wrote:
>> Well, I think we should probably figure out why that is happening first.
> 
> I got my hands on a tcpdump trace. I've trimmed it to this:
> 
> 
> No.     Time           Source                Destination           Protocol Length Info
>        1 0.000000       10.228.194.30         10.228.38.214         NVMe     138    NVMe Write
>        2 0.000285       10.228.38.214         10.228.194.30         NVMe/TCP 90     Ready To Transfer
>        3 0.000591       10.228.194.30         10.228.38.214         NVMe     4186   NVMe Write: Data
>        4 0.000673       10.228.38.214         10.228.194.30         TCP      66     4420 → 58535 [ACK] Seq=25 Ack=4193 Win=241 Len=0 TSval=2655324576 TSecr=1497295579
>        5 0.002140       10.228.38.214         10.228.194.30         NVMe     90     NVMe Write: Response
>        6 0.002511       10.228.194.30         10.228.38.175         NVMe     138    NVMe Write
>        7 0.002812       10.228.38.175         10.228.194.30         NVMe/TCP 90     Ready To Transfer
>        8 0.003006       10.228.194.30         10.228.38.175         NVMe     4186   NVMe Write: Data
>        9 0.003098       10.228.38.175         10.228.194.30         TCP      66     4420 → 51241 [ACK] Seq=25 Ack=4193 Win=241 Len=0 TSval=2183410196 TSecr=3601034207
>       10 0.004420       10.228.38.175         10.228.194.30         NVMe     90     NVMe Write: Response
>       11 0.004890       10.228.38.214         10.228.194.30         NVMe/TCP 90
>       12 0.004969       10.228.38.175         10.228.194.30         NVMe/TCP 90
> 
> 
> The last few seconds contain only normal writes and suddenly the host
> receives two invalid packets. From what I see the host doesn't misbehave
> at all. I wonder if it would be possible to detect the invalid packet by
> locking at the PDU header only. If this would be possible we could
> discard it early and do not try to use the invalid command id.
> 
> Here the last two packets with details:
> 
> 
> No.     Time           Source                Destination           Protocol Length Info
>       11 0.004890       10.228.38.214         10.228.194.30         NVMe/TCP 90
> 
> Frame 11: 90 bytes on wire (720 bits), 90 bytes captured (720 bits)
>      Encapsulation type: Ethernet (1)
>      Arrival Time: Feb 23, 2021 18:16:08.780574000 CET
>      [Time shift for this packet: 0.000000000 seconds]
>      Epoch Time: 1614100568.780574000 seconds
>      [Time delta from previous captured frame: 0.000470000 seconds]
>      [Time delta from previous displayed frame: 0.000470000 seconds]
>      [Time since reference or first frame: 0.004890000 seconds]
>      Frame Number: 11
>      Frame Length: 90 bytes (720 bits)
>      Capture Length: 90 bytes (720 bits)
>      [Frame is marked: False]
>      [Frame is ignored: False]
>      [Protocols in frame: eth:ethertype:ip:tcp:nvme-tcp]
>      [Coloring Rule Name: TCP]
>      [Coloring Rule String: tcp]
> Ethernet II, Src: IntelCor_41:16:c0 (b4:96:91:41:16:c0), Dst: Cisco_9f:f5:a8 (00:00:0c:9f:f5:a8)
>      Destination: Cisco_9f:f5:a8 (00:00:0c:9f:f5:a8)
>          Address: Cisco_9f:f5:a8 (00:00:0c:9f:f5:a8)
>          .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
>          .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
>      Source: IntelCor_41:16:c0 (b4:96:91:41:16:c0)
>          Address: IntelCor_41:16:c0 (b4:96:91:41:16:c0)
>          .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
>          .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
>      Type: IPv4 (0x0800)
> Internet Protocol Version 4, Src: 10.228.38.214, Dst: 10.228.194.30
>      0100 .... = Version: 4
>      .... 0101 = Header Length: 20 bytes (5)
>      Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
>          0000 00.. = Differentiated Services Codepoint: Default (0)
>          .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
>      Total Length: 76
>      Identification: 0x0000 (0)
>      Flags: 0x40, Don't fragment
>          0... .... = Reserved bit: Not set
>          .1.. .... = Don't fragment: Set
>          ..0. .... = More fragments: Not set
>      Fragment Offset: 0
>      Time to Live: 64
>      Protocol: TCP (6)
>      Header Checksum: 0x0000 [validation disabled]
>      [Header checksum status: Unverified]
>      Source Address: 10.228.38.214
>      Destination Address: 10.228.194.30
> Transmission Control Protocol, Src Port: 4420, Dst Port: 46909, Seq: 1, Ack: 1, Len: 24
>      Source Port: 4420
>      Destination Port: 46909
>      [Stream index: 2]
>      [TCP Segment Len: 24]
>      Sequence Number: 1    (relative sequence number)
>      Sequence Number (raw): 4175488220
>      [Next Sequence Number: 25    (relative sequence number)]
>      Acknowledgment Number: 1    (relative ack number)
>      Acknowledgment number (raw): 2966903626
>      1000 .... = Header Length: 32 bytes (8)
>      Flags: 0x018 (PSH, ACK)
>          000. .... .... = Reserved: Not set
>          ...0 .... .... = Nonce: Not set
>          .... 0... .... = Congestion Window Reduced (CWR): Not set
>          .... .0.. .... = ECN-Echo: Not set
>          .... ..0. .... = Urgent: Not set
>          .... ...1 .... = Acknowledgment: Set
>          .... .... 1... = Push: Set
>          .... .... .0.. = Reset: Not set
>          .... .... ..0. = Syn: Not set
>          .... .... ...0 = Fin: Not set
>          [TCP Flags: ·······AP···]
>      Window: 257
>      [Calculated window size: 257]
>      [Window size scaling factor: -1 (unknown)]
>      Checksum: 0xfefa [unverified]
>      [Checksum Status: Unverified]
>      Urgent Pointer: 0
>      Options: (12 bytes), No-Operation (NOP), No-Operation (NOP), Timestamps
>          TCP Option - No-Operation (NOP)
>              Kind: No-Operation (1)
>          TCP Option - No-Operation (NOP)
>              Kind: No-Operation (1)
>          TCP Option - Timestamps: TSval 4211986351, TSecr 1497291787
>              Kind: Time Stamp Option (8)
>              Length: 10
>              Timestamp value: 4211986351
>              Timestamp echo reply: 1497291787
>      [SEQ/ACK analysis]
>          [Bytes in flight: 24]
>          [Bytes sent since last PSH flag: 24]
>      [Timestamps]
>          [Time since first frame in this TCP stream: 0.000000000 seconds]
>          [Time since previous frame in this TCP stream: 0.000000000 seconds]
>      TCP payload (24 bytes)
>      [PDU Size: 24]
> NVM Express Fabrics TCP
>      Pdu Type: CapsuleResponse (5)
>      Pdu Specific Flags: 0x00
>          .... ...0 = PDU Header Digest: Not set
>          .... ..0. = PDU Data Digest: Not set
>          .... .0.. = PDU Data Last: Not set
>          .... 0... = PDU Data Success: Not set
>      Pdu Header Length: 24
>      Pdu Data Offset: 0
>      Packet Length: 24
>      Unknown Data: 02000400000000001c0000001f000000
> 
> 0000  00 00 0c 9f f5 a8 b4 96 91 41 16 c0 08 00 45 00   .........A....E.
> 0010  00 4c 00 00 40 00 40 06 00 00 0a e4 26 d6 0a e4   .L..@.@.....&...
> 0020  c2 1e 11 44 b7 3d f8 e0 e4 dc b0 d7 5b 4a 80 18   ...D.=......[J..
> 0030  01 01 fe fa 00 00 01 01 08 0a fb 0d cf af 59 3e   ..............Y>
> 0040  dc 0b 05 00 18 00 18 00 00 00 02 00 04 00 00 00   ................
> 0050  00 00 1c 00 00 00 1f 00 00 00                     ..........
> 
> No.     Time           Source                Destination           Protocol Length Info
>       12 0.004969       10.228.38.175         10.228.194.30         NVMe/TCP 90
> 
> Frame 12: 90 bytes on wire (720 bits), 90 bytes captured (720 bits)
>      Encapsulation type: Ethernet (1)
>      Arrival Time: Feb 23, 2021 18:16:08.780653000 CET
>      [Time shift for this packet: 0.000000000 seconds]
>      Epoch Time: 1614100568.780653000 seconds
>      [Time delta from previous captured frame: 0.000079000 seconds]
>      [Time delta from previous displayed frame: 0.000079000 seconds]
>      [Time since reference or first frame: 0.004969000 seconds]
>      Frame Number: 12
>      Frame Length: 90 bytes (720 bits)
>      Capture Length: 90 bytes (720 bits)
>      [Frame is marked: False]
>      [Frame is ignored: False]
>      [Protocols in frame: eth:ethertype:ip:tcp:nvme-tcp]
>      [Coloring Rule Name: TCP]
>      [Coloring Rule String: tcp]
> Ethernet II, Src: IntelCor_41:16:c0 (b4:96:91:41:16:c0), Dst: Cisco_9f:f5:a8 (00:00:0c:9f:f5:a8)
>      Destination: Cisco_9f:f5:a8 (00:00:0c:9f:f5:a8)
>          Address: Cisco_9f:f5:a8 (00:00:0c:9f:f5:a8)
>          .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
>          .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
>      Source: IntelCor_41:16:c0 (b4:96:91:41:16:c0)
>          Address: IntelCor_41:16:c0 (b4:96:91:41:16:c0)
>          .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
>          .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
>      Type: IPv4 (0x0800)
> Internet Protocol Version 4, Src: 10.228.38.175, Dst: 10.228.194.30
>      0100 .... = Version: 4
>      .... 0101 = Header Length: 20 bytes (5)
>      Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
>          0000 00.. = Differentiated Services Codepoint: Default (0)
>          .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
>      Total Length: 76
>      Identification: 0x0000 (0)
>      Flags: 0x40, Don't fragment
>          0... .... = Reserved bit: Not set
>          .1.. .... = Don't fragment: Set
>          ..0. .... = More fragments: Not set
>      Fragment Offset: 0
>      Time to Live: 64
>      Protocol: TCP (6)
>      Header Checksum: 0x0000 [validation disabled]
>      [Header checksum status: Unverified]
>      Source Address: 10.228.38.175
>      Destination Address: 10.228.194.30
> Transmission Control Protocol, Src Port: 4420, Dst Port: 34895, Seq: 1, Ack: 1, Len: 24
>      Source Port: 4420
>      Destination Port: 34895
>      [Stream index: 3]
>      [TCP Segment Len: 24]
>      Sequence Number: 1    (relative sequence number)
>      Sequence Number (raw): 3092812012
>      [Next Sequence Number: 25    (relative sequence number)]
>      Acknowledgment Number: 1    (relative ack number)
>      Acknowledgment number (raw): 2384147181
>      1000 .... = Header Length: 32 bytes (8)
>      Flags: 0x018 (PSH, ACK)
>          000. .... .... = Reserved: Not set
>          ...0 .... .... = Nonce: Not set
>          .... 0... .... = Congestion Window Reduced (CWR): Not set
>          .... .0.. .... = ECN-Echo: Not set
>          .... ..0. .... = Urgent: Not set
>          .... ...1 .... = Acknowledgment: Set
>          .... .... 1... = Push: Set
>          .... .... .0.. = Reset: Not set
>          .... .... ..0. = Syn: Not set
>          .... .... ...0 = Fin: Not set
>          [TCP Flags: ·······AP···]
>      Window: 257
>      [Calculated window size: 257]
>      [Window size scaling factor: -1 (unknown)]
>      Checksum: 0xfed3 [unverified]
>      [Checksum Status: Unverified]
>      Urgent Pointer: 0
>      Options: (12 bytes), No-Operation (NOP), No-Operation (NOP), Timestamps
>          TCP Option - No-Operation (NOP)
>              Kind: No-Operation (1)
>          TCP Option - No-Operation (NOP)
>              Kind: No-Operation (1)
>          TCP Option - Timestamps: TSval 3874335934, TSecr 3601030412
>              Kind: Time Stamp Option (8)
>              Length: 10
>              Timestamp value: 3874335934
>              Timestamp echo reply: 3601030412
>      [SEQ/ACK analysis]
>          [Bytes in flight: 24]
>          [Bytes sent since last PSH flag: 24]
>      [Timestamps]
>          [Time since first frame in this TCP stream: 0.000000000 seconds]
>          [Time since previous frame in this TCP stream: 0.000000000 seconds]
>      TCP payload (24 bytes)
>      [PDU Size: 24]
> NVM Express Fabrics TCP
>      Pdu Type: CapsuleResponse (5)
>      Pdu Specific Flags: 0x00
>          .... ...0 = PDU Header Digest: Not set
>          .... ..0. = PDU Data Digest: Not set
>          .... .0.. = PDU Data Last: Not set
>          .... 0... = PDU Data Success: Not set
>      Pdu Header Length: 24
>      Pdu Data Offset: 0
>      Packet Length: 24
>      Unknown Data: 02000400000000001b0000001f000000
> 
> 0000  00 00 0c 9f f5 a8 b4 96 91 41 16 c0 08 00 45 00   .........A....E.
> 0010  00 4c 00 00 40 00 40 06 00 00 0a e4 26 af 0a e4   .L..@.@.....&...
> 0020  c2 1e 11 44 88 4f b8 58 90 ec 8e 1b 32 ed 80 18   ...D.O.X....2...
> 0030  01 01 fe d3 00 00 01 01 08 0a e6 ed ac be d6 a3   ................
> 0040  5d 0c 05 00 18 00 18 00 00 00 02 00 04 00 00 00   ]...............
> 0050  00 00 1b 00 00 00 1f 00 00 00                     ..........
> 
As I suspected, we did receive an invalid frame.
Data digest would have saved us, but then it's not enabled.

So we do need to check if the request is valid before processing it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
